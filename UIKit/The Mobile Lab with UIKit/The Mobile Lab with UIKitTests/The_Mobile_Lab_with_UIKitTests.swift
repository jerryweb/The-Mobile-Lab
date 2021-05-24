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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CreateANewEmptyTrack_withNoGivenName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let mixerTrack = MixerTrackModel(nil)
        
        XCTAssertEqual(mixerTrack.getName(), "Track 1")
        XCTAssertEqual(mixerTrack.getVolume(), 0.5)
        XCTAssertEqual(mixerTrack.getPan(), 0)
        XCTAssertTrue(!mixerTrack.isMuted())
    }
    
    func test_CreateANewEmptyTrack_withAGivenName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let mixerTrack = MixerTrackModel("Default")
        
        XCTAssertEqual(mixerTrack.getName(), "Default")
        XCTAssertEqual(mixerTrack.getVolume(), 0.5)
        XCTAssertEqual(mixerTrack.getPan(), 0)
        XCTAssertTrue(!mixerTrack.isMuted())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
