//
//  PlayBackEngineTests.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class PlayBackEngineTests : XCTestCase {
    
    func test_CreatePlayBackEngine() {
        let playBackEngine = PlayBackEngine()
        XCTAssertNotNil(playBackEngine)
    }
}
