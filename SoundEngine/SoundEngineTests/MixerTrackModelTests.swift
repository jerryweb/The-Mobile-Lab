//
//  MixerTrackModelTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 9/3/21.
//

import XCTest
@testable import SoundEngine

class MixerTrackModelTests : XCTestCase {
    
    func test_CreateDefaultMixerTrack() {
        let mixerTrack = MixerTrackModel()
        
        XCTAssertEqual(mixerTrack.name, "track 1")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertNil(mixerTrack.soundGeneratorModel)
    }
    
    
    
}
