// swift-tools-version:5.7

//
// This source file is part of the CardinalKit open-source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "CardinalKitHealthKitToFHIRAdapter",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "CardinalKitHealthKitToFHIRAdapter", targets: ["CardinalKitHealthKitToFHIRAdapter"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/FHIRModels", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/StanfordBDHG/CardinalKit", .upToNextMinor(from: "0.3.5")),
        .package(url: "https://github.com/StanfordBDHG/HealthKitOnFHIR", .upToNextMinor(from: "0.2.3"))
    ],
    targets: [
        .target(
            name: "CardinalKitHealthKitToFHIRAdapter",
            dependencies: [
                .product(name: "CardinalKit", package: "CardinalKit"),
                .product(name: "FHIR", package: "CardinalKit"),
                .product(name: "HealthKitDataSource", package: "CardinalKit"),
                .product(name: "ModelsR4", package: "FHIRModels"),
                .product(name: "HealthKitOnFHIR", package: "HealthKitOnFHIR")
            ]
        ),
        .testTarget(
            name: "CardinalKitHealthKitToFHIRAdapterTests",
            dependencies: [
                .target(name: "CardinalKitHealthKitToFHIRAdapter")
            ]
        )
    ]
)
