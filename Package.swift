// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "EZDataSource",
    platforms: [
        .iOS("15.0"),
        .macOS("12.0"),
    ],
    products: [
        .library(
            name: "EZDataSource",
            targets: ["EZDataSource"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.56.1"),
    ],
    targets: [
        .target(
            name: "EZDataSource",
            dependencies: [],
            path: "DataSource/Classes",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
    ]
)
