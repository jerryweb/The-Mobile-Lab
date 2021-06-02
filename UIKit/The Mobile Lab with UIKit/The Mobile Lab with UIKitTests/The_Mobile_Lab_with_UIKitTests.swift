//
//  The_Mobile_Lab_with_UIKitTests.swift
//  The Mobile Lab with UIKitTests
//  Contains texts for
//
//  Created by Jerry on 5/23/21.
//

import XCTest
@testable import The_Mobile_Lab_with_UIKit

class MixerAndMixerTrackTests: XCTestCase {
    
    let mixerTrackModel = MixerTrackModel(nil)

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    
    func test_CreateANewEmptyTrack_withNoGivenName() throws {
        
        let mixerTrack = MixerTrackModel(nil)
        
        XCTAssertEqual(mixerTrack.trackName, "Track 1")
    }
    
    func test_CreateANewEmptyTrack_withAGivenName() throws {
        
        let mixerTrack = MixerTrackModel("Default")
        
        XCTAssertEqual(mixerTrack.trackName, "Default")
    }
    
    func test_CreateNewTrackWithDefaultValues() throws {
                
        XCTAssertEqual(mixerTrackModel.volume, 0.5)
        XCTAssertEqual(mixerTrackModel.pan, 0)
        XCTAssertTrue(!mixerTrackModel.mute)
    }
    
    func test_ChangeMixerTrackVolume() throws {
                
        mixerTrackModel.setVolume(0.56)
        XCTAssertEqual(mixerTrackModel.volume, 0.56)
        
        mixerTrackModel.setVolume(0.003)
        XCTAssertEqual(mixerTrackModel.volume, 0.003)
    }
    
    func test_SettingMixerTrackVolumePastMaxValue_SetsToMaxValue() throws {
                
        mixerTrackModel.setVolume(Volume.maxVolume + 0.00001)
        XCTAssertEqual(mixerTrackModel.volume, 1)
    }
    
    func test_SettingMixerTrackVolumePastMinValue_SetsToMinValue() throws {
                
        mixerTrackModel.setVolume(Volume.minVolume - 0.0000001)
        XCTAssertEqual(mixerTrackModel.volume, 0)
    }
    
    func test_SettingMixerTrackPanPastLetfPanLimit_SetsToletfPanLimit() throws {
                
        mixerTrackModel.setPan(Pan.letfPanLimit - 0.000001)
        XCTAssertEqual(mixerTrackModel.pan, Pan.letfPanLimit)
    }
    
    func test_SettingMixerTrackPanPastRightPanLimit_SetsToletfPanLimit() throws {
                
        mixerTrackModel.setPan(Pan.rightPanLimit + 0.000001)
        XCTAssertEqual(mixerTrackModel.pan, Pan.rightPanLimit)
    }

    func test_MuteMixer() throws {
                
        mixerTrackModel.setVolume(Volume.minVolume - 0.0000001)
        XCTAssertEqual(mixerTrackModel.volume, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
