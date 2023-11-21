// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "EZDataSource",
    platforms: [
        .iOS("14.0"),
    ],
    products: [
        .library(
            name: "EZDataSource",
            targets: ["EZDataSource"]),
    ],
    dependencies: [
        .package(url: "git@github.com:realm/SwiftLint", exact: "0.53.0"),
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
