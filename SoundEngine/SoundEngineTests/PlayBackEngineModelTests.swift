//
//  PlayBackEngineModelTests.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import XCTest

@testable import SoundEngine

class PlayBackEngineModelTests : XCTest {
    
    func test_CreatePlaybackEngineModel() {
        let playbackEngine = PlayBackEngineModel()
        
        XCTAssertNotNil(playbackEngine)
    }
}
