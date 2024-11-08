// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoggerKit",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "LoggerKit",
            targets: ["LoggerKit"]),
    ],
    targets: [
        .target(
            name: "LoggerKit",
            dependencies: []),
        .testTarget(
            name: "LoggerTests",
            dependencies: ["LoggerKit"]),
    ]
)
