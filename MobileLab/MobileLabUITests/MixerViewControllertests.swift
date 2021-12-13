//
//  MixerViewControllertests.swift
//  MobileLabUITests
//
//  Created by Jerry on 12/12/21.
//

import XCTest

class MixerViewControllertests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.activate()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func test_verifyUIElementsExistOnCreation() throws {
        XCTAssertTrue(app.sliders["MASTER_VOLUME_FADER"].exists)
        XCTAssertTrue(app.staticTexts["MASTER_VOLUME_PERCENTAGE_LABEL"].exists)
        XCTAssertTrue(app.staticTexts["MASTER_LABEL"].exists)
    }

}
