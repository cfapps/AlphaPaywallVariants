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
            name: "PaywallsKit",
            targets: [
                "PaywallsKit"
            ]
        ),
        .library(
            name: "PaywallSnowballKit",
            targets: [
                "PaywallSnowballKit"
            ]
        ),
        .library(
            name: "PaywallCloverKit",
            targets: [
                "PaywallCloverKit"
            ]
        ),
        .library(
            name: "PaywallMosesKit",
            targets: [
                "PaywallMosesKit"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.0")
    ],
    targets: [
        .target(
            name: "PaywallsKit",
            path: "Sources/_Common"
        ),
        .target(
            name: "SharedKit",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Lottie", package: "lottie-spm"),
            ],
            path: "Sources/_Shared"
        ),
        .target(
            name: "PaywallSnowballKit",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Lottie", package: "lottie-spm"),
                "SharedKit",
                "PaywallsKit"
            ],
            path: "Sources/Snowball",
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "PaywallCloverKit",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Lottie", package: "lottie-spm"),
                "SharedKit",
                "PaywallsKit"
            ],
            path: "Sources/Clover",
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "PaywallMosesKit",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Lottie", package: "lottie-spm"),
                "SharedKit",
                "PaywallsKit"
            ],
            path: "Sources/Moses",
            resources: [
                .process("Resources"),
            ]
        )
    ]
)
