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
        .package(url: "git@github.com:realm/SwiftLint", .upToNextMinor(from: "0.54.0")),
    ],
    targets: [
        .target(
            name: "EZDataSource",
            dependencies: [],
            path: "DataSource/Classes",
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
    ]
)
