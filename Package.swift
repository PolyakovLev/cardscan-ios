// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CardScan",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "CardScan",
            targets: ["CardScan"]
        ),
    ],
    targets: [
        .testTarget(name: "CardScan", dependencies: [], path: "CardScan/CardScan")
    ]
)
