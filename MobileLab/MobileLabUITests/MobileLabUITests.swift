//
//  MobileLabUITests.swift
//  MobileLabUITests
//
//  Created by Jerry on 11/15/21.
//
import Foundation
import XCTest

class MobileLabUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().activate()
    }

    override func tearDownWithError() throws {
        XCUIApplication().terminate()
    }

    func test_verifyAllUIElementsExist() throws {
        let app = buildSUT()
        
        XCTAssertTrue(app.buttons["DRUM_PAD_0"].exists)
        XCTAssertTrue(app.buttons["DRUM_PAD_1"].exists)
        XCTAssertTrue(app.buttons["DRUM_PAD_2"].exists)
        XCTAssertTrue(app.buttons["DRUM_PAD_3"].exists)
        XCTAssertTrue(app.buttons["DRUM_PAD_4"].exists)
        XCTAssertTrue(app.buttons["DRUM_PAD_5"].exists)
        XCTAssertTrue(app.buttons["DRUM_PAD_6"].exists)
        XCTAssertTrue(app.buttons["DRUM_PAD_7"].exists)

        XCTAssertTrue(app.sliders["MASTER_VOLUME_FADER"].exists)
        XCTAssertTrue(app.staticTexts["MASTER_VOLUME_PERCENTAGE_LABEL"].exists)
        XCTAssertTrue(app.staticTexts["MASTER_LABEL"].exists)
        XCTAssertTrue(app.segmentedControls["DRUM_PAD_SOUND_BANK_SEGMENT_CONTROL"].exists)
//        let masterVolumeSlider = app.sliders["MASTER_VOLUME_FADER"]
//        XCTAssertTrue(masterVolumeSlider.exists)
//
//        app.sliders["MASTER_VOLUME_FADER"].adjust(toNormalizedSliderPosition: 0.2)
//        XCTAssertTrue(app.staticTexts["20%"].exists)
//
//        masterVolumeSlider.value = 0.9
//
//        let app = XCUIApplication()
//        app.staticTexts["75%"].tap()
//        app.staticTexts["Master"].tap()
        
//        XCTAssertEqual(masterVolumePercentageLabel, String(0.9))
    }
    
    func test_verifySegmentSelection() throws {
        let app = buildSUT()        
        
        let bank1Button = app/*@START_MENU_TOKEN@*/.buttons["Bank 1"]/*[[".segmentedControls[\"DRUM_PAD_SOUND_BANK_SEGMENT_CONTROL\"].buttons[\"Bank 1\"]",".buttons[\"Bank 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let bank2Button = app/*@START_MENU_TOKEN@*/.buttons["Bank 2"]/*[[".segmentedControls[\"DRUM_PAD_SOUND_BANK_SEGMENT_CONTROL\"].buttons[\"Bank 2\"]",".buttons[\"Bank 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                
    }
    
    func buildSUT() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .landscapeRight
        return app
    }
}

//extension XCUIElement {
//    open func adjustSlider(setSliderValue: CGFloat){
//        let start = coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
//        let end = coordinate(withNormalizedOffset: CGVector(dx: setSliderValue, dy: 0.0))
//        start.press(forDuration: 0.05, thenDragTo: end)
//    }
//}

// extention to handle sliders
//extension XCUIElement {
//    
//    open func adjustSlider(toNormalizedSliderValue normalizedSliderValue: CGFloat) {
//        let start = coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
//        let end = coordinate(withNormalizedOffset: CGVector(dx: normalizedSliderValue, dy: 0.0))
//        start.press(forDuration: 0.05, thenDragTo: end)
//    }
//}
