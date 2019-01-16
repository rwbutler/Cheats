// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Cheats",
    products: [
        .library(
            name: "Cheats",
            targets: ["Cheats"])
    ],
    targets: [
        .target(
            name: "Cheats",
            path: "Cheats",
            exclude: ["Classes/UI"])
    ]
)
