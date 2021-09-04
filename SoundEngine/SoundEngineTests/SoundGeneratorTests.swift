//
//  SoundEngineTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/26/21.
//

import XCTest
@testable import SoundEngine


// MARK: Sound Generator Tests
class SoundGeneratorTests: XCTestCase {
    let soundGenerator = SoundGeneratorModel(generatorName: nil)
    
    func test_CreateNewSoundGenerator_withGivenName() throws {
        let kickSoundGenerator = SoundGeneratorModel(generatorName: "Kick")

        XCTAssertEqual(kickSoundGenerator.name, "Kick")
        XCTAssertNotNil(kickSoundGenerator)
    }
    
    func test_CreateNewSoundGenerator_verifyDefaultValues() throws {
                
        XCTAssertEqual(soundGenerator.name, "Sample")
        XCTAssertEqual(soundGenerator.audioPlayerNode.volume, 1.0)
        XCTAssertEqual(soundGenerator.audioPlayerNode.pan, 0.0)
    }
}
