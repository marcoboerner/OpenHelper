// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenHelper",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OpenHelper",
            targets: ["OpenHelper"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "OpenHelper",
            dependencies: []),
        .testTarget(
            name: "OpenHelperTests",
            dependencies: ["OpenHelper"]),
    ]
)
