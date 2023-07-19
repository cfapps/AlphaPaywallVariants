// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlphaPaywallVariants",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AlphaPaywallVariants",
            targets: ["AlphaPaywallVariants"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
        .package(url: "https://github.com/QuickTableKit/QuickTableKit.git", .upToNextMajor(from: "0.1.2")),
    ],
    targets: [
        .target(
            name: "AlphaPaywallVariants",
            dependencies: [
                "SnapKit",
                "QuickTableKit"
            ]
        )
    ]
)
