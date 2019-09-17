// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GPIOTests",
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "GPIOTests",
            dependencies: ["SwiftyGPIO"]),
        .testTarget(
            name: "GPIOTestsTests",
            dependencies: ["GPIOTests"]),
    ]
)
