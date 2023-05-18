//
// This source file is part of the Stanford Spezi open-source project.
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@preconcurrency import SpeziFHIR
import SpeziHealthKit
import SwiftUI


struct ContentView: View {
    @EnvironmentObject var healthKitComponent: HealthKit<FHIR>
    @EnvironmentObject var fhirStandard: FHIR
    @State var testState = "Awaiting Check ..."
    
    
    var body: some View {
        VStack {
            Button("HealthKit Authorization") {
                _Concurrency.Task {
                    try await healthKitComponent.askForAuthorization()
                }
            }
            Button("Pull HealthKit Data") {
                _Concurrency.Task {
                    await healthKitComponent.triggerDataSourceCollection()
                }
            }
            Button("Check ECG Data") {
                _Concurrency.Task {
                    let observations = await fhirStandard.resources(resourceType: Observation.self)
                    
                    guard observations.count == 3 else {
                        testState = "Unexpected number of observations: \(observations.count)"
                        return
                    }
                    
                    testState = "Passed"
                }
            }
            Text(testState)
        }
            .navigationTitle("Tests")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
