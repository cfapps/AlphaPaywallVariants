// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlphaPaywallsKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AlphaPaywallSheet",
            targets: ["AlphaPaywallSheet"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
        .package(url: "https://github.com/QuickToolKit/QuickToolKit.git", .upToNextMajor(from: "0.2.0")),
    ],
    targets: [
        .target(
            name: "AlphaPaywallSheet",
            dependencies: [
                "SnapKit",
                "QuickToolKit"
            ],
            path: "Sources/Sheet"
        )
    ]
)
