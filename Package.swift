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
    dependencies: [],
        targets: [
            .binaryTarget(
                name: "CardScan",
                url: "https://github.com/PolyakovLev/cardscan-ios/blob/BuildFramework/CardScan.xcframework.zip",
                checksum: "80b5bfe7cdb44c2c3f95cb32e87d5c18d8481f74aaa8b4a4ee17e4fc4a9cbe76"
            )
        ]
)
