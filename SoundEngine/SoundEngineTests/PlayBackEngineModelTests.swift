//
//  PlayBackEngineModelTests.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class SoundEngineControllerTests : XCTestCase {
    
    func test_CreateSoundEngineController() {
        let soundEngineController = SoundEngineController()
        XCTAssertNotNil(soundEngineController)
    }
}
