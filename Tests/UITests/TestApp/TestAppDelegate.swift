//
// This source file is part of the Stanford Spezi open-source project.
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@preconcurrency import HealthKit
import Spezi
import SpeziFHIR
import SpeziHealthKit
import SpeziHealthKitToFHIRAdapter
import SwiftUI


class TestAppDelegate: SpeziAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: FHIR()) {
            if HKHealthStore.isHealthDataAvailable() {
                HealthKit {
                    CollectSample(HKQuantityType.electrocardiogramType())
                    CollectSamples(Set(HKElectrocardiogram.correlatedSymptomTypes))
                } adapter: {
                    HealthKitToFHIRAdapter()
                }
            }
        }
    }
}
