import DiscordBM
import Foundation
import TOMLDecoder

@main
@MainActor
struct MacMan {
    static let config = try! TOMLDecoder().decode(
        Config.self, from: Data(PackageResources.config_toml))
    static func main() async {
        let commands = config.commands.map { key, value in
            Payloads.ApplicationCommandCreate(
                name: key,
                description: "the \(key) command",
                options: [],
            )
        }

        let bot = await BotGatewayManager(
            token: ProcessInfo.processInfo.environment["TOKEN"]!.trimmingCharacters(
                in: .whitespacesAndNewlines),
            intents: Gateway.Intent.unprivileged
        )

        print("Logging in...")
        await bot.connect()
        print("Logged in")
        print(config.commands)
        try! await bot.client.bulkSetApplicationCommands(payload: commands).guardSuccess()
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
        case .applicationCommand(let command):
            try await client.updateOriginalInteractionResponse(
                token: interaction.token,
                payload: Payloads.EditWebhookMessage(
                    content: "Hello, You wanted me to echo something!",
                    embeds: [
                        Embed(
                            title: "This is an embed",
                            description: MacMan.config.commands[command.name],
                            timestamp: Date(),
                            color: .init(value: .random(in: 0..<(1 << 24))),
                            footer: .init(text: "Footer!"),
                            author: .init(name: "Authored by DiscordBM!"),
                            fields: [
                                .init(name: "field name!", value: "field value!")
                            ]
                        )
                    ],
                    components: [
                        [
                            .button(
                                .init(
                                    label: "Open Slackow.com!",
                                    url: "https://slackow.com"
                                ))
                        ]
                    ]
                )
            ).guardSuccess()
        default:
            break
        }
    }
}

struct Config: Decodable {
    let commands: [String: String]
}
