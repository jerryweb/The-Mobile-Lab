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
    
    override func setUpWithError() throws {
//        soundGenerator.setVolume(1.0)
    }
    
    func test_CreateNewSoundGenerator_withGivenName() throws {
        let kickSoundGenerator = SoundGeneratorModel(generatorName: "Kick")

        XCTAssertEqual(kickSoundGenerator.name, "Kick")
        XCTAssertNotNil(kickSoundGenerator)
    }
    
    
    func test_CreateNewSoundGenerator_verifyDefaultValues() throws {
                
        XCTAssertEqual(soundGenerator.name, "Sample")
        XCTAssertEqual(soundGenerator.volume, 1.0)
        XCTAssertEqual(soundGenerator.pan, 0.0)
        XCTAssertNil(soundGenerator.audioFile)
    }
    
    func test_ModifySoundGeneratorVolume() throws {
        XCTAssertEqual(soundGenerator.volume, 1.0)
        
        soundGenerator.setVolume(0.333)
        
        XCTAssertEqual(soundGenerator.volume, 0.333)
    }
    
    func test_VerifySoundGeneratorVolumeLimits() throws {
        XCTAssertEqual(soundGenerator.volume, 1.0)
        
        soundGenerator.setVolume(1.00001)
        XCTAssertEqual(soundGenerator.volume, 1.0)
        
        soundGenerator.setVolume(0.0)
        XCTAssertEqual(soundGenerator.volume, 0.0)
    }
    
    func test_VerifySoundGeneratorPanLimits() throws {
        XCTAssertEqual(soundGenerator.pan, 0.0)
        
        soundGenerator.setPan(1.00001)
        XCTAssertEqual(soundGenerator.pan, 1.0)
        
        soundGenerator.setPan(-1.00001)
        XCTAssertEqual(soundGenerator.pan, -1.0)
    }

}
