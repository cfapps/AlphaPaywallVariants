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
            name: "AlphaPaywallsKit",
            targets: ["AlphaPaywallsKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
        .package(url: "https://github.com/QuickTableKit/QuickTableKit.git", .upToNextMajor(from: "0.1.6")),
    ],
    targets: [
        .target(
            name: "AlphaPaywallsKit",
            dependencies: [
                "SnapKit",
                "QuickTableKit"
            ]
        )
    ]
)
