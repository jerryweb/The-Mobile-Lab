//
//  TransportControlsViewControllerTests.swift
//  MobileLabUITests
//
//  Created by Jerry on 12/2/21.
//

import XCTest

class TransportControlsViewControllerTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.activate()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testExample() throws {
        XCTAssertTrue(app.buttons["PLAY_BUTTON"].exists)
        XCTAssertTrue(app.buttons["STOP_BUTTON"].exists)
        XCTAssertTrue(app.buttons["PAUSE_BUTTON"].exists)
        XCTAssertTrue(app.buttons["RECORD_BUTTON"].exists)
        XCTAssertTrue(app.buttons["METRONOME_TOGGLE_BUTTON"].exists)
        XCTAssertTrue(app.steppers["BPM_STEPPER"].exists)
        XCTAssertTrue(app.staticTexts["BPM_TEXT_LABEL"].exists)
        XCTAssertTrue(app.textFields["BPM_TEXT_FIELD"].exists)
        XCTAssertTrue(app.staticTexts["BAR_VALUE_LABEL"].exists)
        XCTAssertTrue(app.staticTexts["BEAT_VALUE_LABEL"].exists)
        
    }
    
    func buildSUT() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .landscapeRight
        return app
    }

}
