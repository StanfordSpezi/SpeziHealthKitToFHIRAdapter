//
// This source file is part of the Stanford Spezi open-source project.
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit
import ModelsR4
import SpeziHealthKitToFHIRAdapter
import XCTest


final class SpeziHealthKitToFHIRAdapterTests: XCTestCase {
    func testSpeziHealthKitToFHIRAdapterElementTests() async throws {
        let adapter = HealthKitToFHIRAdapter()
        
        let stepCountSample = HKQuantitySample(
            type: HKQuantityType(.stepCount),
            quantity: HKQuantity(
                unit: .count(),
                doubleValue: 42
            ),
            start: .now,
            end: .now
        )
        
        let transformedElement = try await adapter.transform(element: stepCountSample)
        let observation = try XCTUnwrap(transformedElement as? Observation)
        
        XCTAssert(observation.status == .final)
        XCTAssert(observation.code.coding?.contains(where: { $0.code?.value?.string == "HKQuantityTypeIdentifierStepCount" }) ?? false)
        guard case let .quantity(quantity) = observation.value else {
            XCTFail("Failed to encode value ...")
            return
        }
        
        XCTAssertEqual(quantity.value?.value?.decimal, 42)
    }
    
    func testSpeziHealthKitToFHIRAdapterRemovalContextTests() async throws {
        let adapter = HealthKitToFHIRAdapter()
        
        let id = UUID()
        let sampleType = HKQuantityType(.stepCount)
        let removalContext = HealthKitToFHIRAdapter.InputRemovalContext(id: id, sampleType: sampleType)
        
        let transformedRemovalContext = try await adapter.transform(removalContext: removalContext)
        
        XCTAssertEqual(transformedRemovalContext.id?.value?.string, id.uuidString)
        XCTAssertEqual(transformedRemovalContext.resourceType, .observation)
    }
}
