// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "EZDataSource",
    platforms: [
        .iOS("13.2"),
    ],
    products: [
        .library(
            name: "EZDataSource",
            targets: ["EZDataSource"]),
    ],
    targets: [
        .target(
            name: "EZDataSource",
            dependencies: [],
            path: "DataSource/Classes"),
    ]
)
