// swift-tools-version:5.7

//
// This source file is part of the Stanford Spezi open-source project.
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "SpeziHealthKitToFHIRAdapter",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "SpeziHealthKitToFHIRAdapter", targets: ["SpeziHealthKitToFHIRAdapter"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/FHIRModels", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/StanfordSpezi/Spezi", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/StanfordSpezi/SpeziFHIR", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/StanfordSpezi/SpeziHealthKit", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/StanfordBDHG/HealthKitOnFHIR", .upToNextMinor(from: "0.2.3"))
    ],
    targets: [
        .target(
            name: "SpeziHealthKitToFHIRAdapter",
            dependencies: [
                .product(name: "Spezi", package: "Spezi"),
                .product(name: "SpeziFHIR", package: "SpeziFHIR"),
                .product(name: "SpeziHealthKit", package: "SpeziHealthKit"),
                .product(name: "ModelsR4", package: "FHIRModels"),
                .product(name: "HealthKitOnFHIR", package: "HealthKitOnFHIR")
            ]
        ),
        .testTarget(
            name: "SpeziHealthKitToFHIRAdapterTests",
            dependencies: [
                .target(name: "SpeziHealthKitToFHIRAdapter")
            ]
        )
    ]
)
