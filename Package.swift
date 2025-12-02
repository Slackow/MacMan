// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MacMan",
    platforms: [
        .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/dduan/TOMLDecoder", .upToNextMinor(from: "0.3.2")),
        .package(url: "https://github.com/DiscordBM/DiscordBM", from: "1.13.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "MacMan",
            dependencies: [
                .product(name: "TOMLDecoder", package: "TOMLDecoder"),
                .product(name: "DiscordBM", package: "DiscordBM"),
            ],
            path: "Sources",
            resources: [
                .embedInCode("../Resources/config.toml")
            ],
        ),
    ],
)
