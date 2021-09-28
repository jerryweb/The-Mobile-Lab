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
    let soundGenerator = SoundGenerator(generatorName: nil)
    
    func test_CreateNewSoundGenerator_withGivenName() throws {
        let kickSoundGenerator = SoundGenerator(generatorName: "Kick")

        XCTAssertEqual(kickSoundGenerator.name, "Kick")
        XCTAssertNotNil(kickSoundGenerator)
    }
    
    func test_CreateNewSoundGenerator_verifyDefaultValues() throws {
                
        XCTAssertEqual(soundGenerator.name, "Sample")
        XCTAssertEqual(soundGenerator.audioPlayerNode.volume, 1.0)
        XCTAssertEqual(soundGenerator.audioPlayerNode.pan, 0.0)
    }
    
    func test_ModfiySoundGeneratorVolume() throws {
        
        XCTAssertEqual(soundGenerator.audioPlayerNode.volume , 1.0)
        soundGenerator.setVolume(0.333)
        XCTAssertEqual(soundGenerator.audioPlayerNode.volume , 0.333)
    }
    
    func test_ModfiySoundGeneratorPan() throws {
        
        XCTAssertEqual(soundGenerator.audioPlayerNode.pan , 0.0)
        soundGenerator.setPan(-0.259)
        XCTAssertEqual(soundGenerator.audioPlayerNode.pan , -0.259)
    }

    func test_VerifySoundGeneratorVolumeLimits() throws {
        XCTAssertEqual(soundGenerator.audioPlayerNode.volume, 1.0)

        soundGenerator.setVolume(1.00001)
        XCTAssertEqual(soundGenerator.audioPlayerNode.volume, 1.0)

        soundGenerator.setVolume(-7.0)
        XCTAssertEqual(soundGenerator.audioPlayerNode.volume, 0.0)
    }

    func test_VerifySoundGeneratorPanLimits() throws {
        XCTAssertEqual(soundGenerator.audioPlayerNode.pan, 0.0)

        soundGenerator.setPan(1.00001)
        XCTAssertEqual(soundGenerator.audioPlayerNode.pan, 1.0)

        soundGenerator.setPan(-1.00001)
        XCTAssertEqual(soundGenerator.audioPlayerNode.pan, -1.0)
    }

    func test_LoadSoundSourceforSoundGenerator() throws {
        soundGenerator.loadSoundSource(SoundEngine.SoundSource())

        XCTAssertNotNil(soundGenerator.getSoundSource())
    }
}
