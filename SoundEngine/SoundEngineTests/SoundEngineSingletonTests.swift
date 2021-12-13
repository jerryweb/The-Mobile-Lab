//
//  SoundEngineSingletonTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 12/13/21.
//

import XCTest
@testable import SoundEngine

class SoundEngineSingletonTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_accessSoundEngineSingleton() throws {
        let soundEngine = SoundEngineSingleton.shared
        XCTAssertNotNil(soundEngine.playbackEngine)
        XCTAssertTrue(soundEngine.playbackEngine.mixerTracks.isEmpty)
        XCTAssertTrue(soundEngine.playbackEngine.soundGenerators.isEmpty)
        XCTAssertFalse(soundEngine.playbackEngine.isPlaying)
    }
}
