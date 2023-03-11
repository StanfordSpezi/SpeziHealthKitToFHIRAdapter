//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import XCTest
import XCTestExtensions
import XCTHealthKit


class TestAppUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
    }
    
    
    func testCardinalKitHealthKitToFHIRAdapterWithECG() throws {
        let app = XCUIApplication()
        app.deleteAndLaunch(withSpringboardAppName: "TestApp")
        
        XCTAssert(app.buttons["HealthKit Authorization"].waitForExistence(timeout: 2))
        app.buttons["HealthKit Authorization"].tap()
        
        try app.handleHealthKitAuthorization()
        
        sleep(2)
        
        try exitAppAndOpenHealth(.electrocardiograms)
        
        app.launch()
        
        XCTAssert(app.buttons["Pull HealthKit Data"].waitForExistence(timeout: 2))
        app.buttons["Pull HealthKit Data"].tap()
        
        sleep(2)
        
        XCTAssert(app.buttons["Check ECG Data"].waitForExistence(timeout: 2))
        app.buttons["Check ECG Data"].tap()
        
        XCTAssert(app.staticTexts["Passed"].waitForExistence(timeout: 2))
    }
}
