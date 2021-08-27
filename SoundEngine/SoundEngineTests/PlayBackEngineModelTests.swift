//
//  PlayBackEngineModelTests.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class PlayBackEngineModelTests : XCTestCase {
    
    func test_CreatePlaybackEngineModel() {
        let playbackEngine = PlayBackEngineModel()
        XCTAssertNotNil(playbackEngine)
    }
}
