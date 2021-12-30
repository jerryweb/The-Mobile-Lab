//
//  MixerCollectionViewCellTests.swift
//  MobileLabUITests
//
//  Created by Jerry on 12/29/21.
//

import XCTest

class MixerCollectionViewCellTests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.activate()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }


    func test_verifyMixerControllerViewCellCreated() throws {
        
        app.tabBars["Tab Bar"].buttons["Search"].tap()
        
        let cell = app.collectionViews.children(matching: .cell).element(boundBy: 0)
           
        XCTAssertTrue(cell/*@START_MENU_TOKEN@*/.staticTexts["CHANNEL_VOLUME_LABEL"]/*[[".staticTexts[\"VOL\"]",".staticTexts[\"CHANNEL_VOLUME_LABEL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(cell.staticTexts["CHANNEL_MUTE_LABEL"].exists)
        XCTAssertTrue(cell.staticTexts["CHANNEL_PAN_LABEL"].exists)
        XCTAssertTrue(cell.staticTexts["CHANNEL_RIGHT_LABEL"].exists)
        XCTAssertTrue(cell.staticTexts["TRACK_LABEL"].exists)
        
        XCTAssertTrue(cell.sliders["MIXER_TRACK_VOLUME_FADER"].exists)
        XCTAssertTrue(cell.sliders["MIXER_TRACK_PAN_SLIDER"].exists)
        
        XCTAssertTrue(cell.buttons["MUTE_BUTTON"].exists)
        
    }

}
