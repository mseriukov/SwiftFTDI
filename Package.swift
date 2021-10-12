// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFTDI",
    products: [        
        .library(
            name: "SwiftFTDI",
            targets: ["SwiftFTDI"]),
    ],
    targets: [
        .systemLibrary(
            name: "clibftdi",
            pkgConfig: "libftdi1",
            providers: [
                .brew(["libftdi"]),
                .apt(["libftdi"]),
            ]
        ),
        .target(
            name: "SwiftFTDI",
            dependencies: ["clibftdi"]
        ),
    ]
)
