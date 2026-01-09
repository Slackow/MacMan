import DiscordBM
import Foundation
import TOMLDecoder

@main
@MainActor
struct MacMan {
    static var config = try! TOMLDecoder().decode(
        Config.self, from: Data(PackageResources.config_toml))
    static func main() async throws {
        config.commands["yo_macman"] = CommandValue(description: "Say yo to MacMan!", message: "b")
        config.commands["hi_macman"] = CommandValue(description: "Say hi to MacMan!", message: "b")
        // dummy entry so commands recognizes itself
        config.commands["commands"] = CommandValue(description: "a", message: "b")
        config.commands["commands"] = CommandValue(
            description: "Outputs a list of commands",
            message: """
                Available commands include:
                ```
                \(config.commands.keys.grouped {String($0.first ?? "a")} .map{"[\($0.uppercased())] \($1.sorted().map{"/\($0)"}.joined(separator: ", "))"}.sorted().joined(separator: "\n"))
                ```
                """)
        let commands = try config.commands.map { name, command in
            guard command.message.trim().count <= 1975 else { throw MacManError.invalidInput }
            return Payloads.ApplicationCommandCreate(
                name: name,
                description: command.description.isEmpty
                    ? "the \(name) command" : command.description,
                // options: [.init(type: .user, name: "tag", description: "user to tag with response", required: false)],
            )
        }

        let bot = await BotGatewayManager(
            token: ProcessInfo.processInfo.environment["TOKEN"]!.trim(),
            intents: Gateway.Intent.unprivileged
        )

        print("Logging in...")
        await bot.connect()
        print("Logged in")
        try await bot.client.bulkSetApplicationCommands(payload: commands).guardSuccess()
        await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask {
                for await event in await bot.events {
                    await EventHandler(event: event, client: bot.client).handleAsync()
                }
            }
        }
    }
}

struct EventHandler: GatewayEventHandler {
    let event: Gateway.Event
    let client: any DiscordClient

    func onInteractionCreate(_ interaction: Interaction) async throws {
        try await client.createInteractionResponse(
            id: interaction.id,
            token: interaction.token,
            payload: .deferredChannelMessageWithSource()
        ).guardSuccess()

        switch interaction.data {
        case .applicationCommand(let c) where c.name == "yo_macman":
            try await client.updateOriginalInteractionResponse(
                token: interaction.token,
                payload: Payloads.EditWebhookMessage(
                    content: "Yo, \(interaction.member?.user?.global_name ?? "")! :)",
                    embeds: [],
                    components: [],
                ),
            ).guardSuccess()
        case .applicationCommand(let c) where c.name == "hi_macman":
            try await client.updateOriginalInteractionResponse(
                token: interaction.token,
                payload: Payloads.EditWebhookMessage(
                    content: "hi \(interaction.member?.user?.global_name ?? "")",
                    embeds: [],
                    components: [],
                ),
            ).guardSuccess()
        case .applicationCommand(let command):
            try await client.updateOriginalInteractionResponse(
                token: interaction.token,
                payload: Payloads.EditWebhookMessage(
                    content: MacMan.config.commands[command.name]?.message.trim() ?? "<blank>",
                    embeds: [],
                    components: [],
                ),
            ).guardSuccess()
        default:
            break
        }
    }
}

struct Config: Decodable {
    var commands: [String: CommandValue]
}

struct CommandValue: Decodable {
    let description: String
    let message: String
}

extension String {
    fileprivate func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

enum MacManError: Error {
    case invalidInput
}
