//
//  SoundGeneratorController.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/29/21.
//

import XCTest
@testable import SoundEngine

// MARK: Sound Generator Controller Tests
class SoundGeneratorControllerTests : XCTestCase {
    
    let soundGeneratorController = SoundGeneratorController()
    
    func test_SetSoundGeneratorModelForSoundGeneratorController() throws {
        
        let soundGeneratorModel = SoundGeneratorModel(generatorName: "Sound Generator Model")
        soundGeneratorController.setSoundGenerator(soundGeneratorModel)
        
        XCTAssertNotNil(soundGeneratorController.getSoundGenerator())
    }
    
    func test_ModfiySoundGeneratorVolume() throws {
        
        let soundGeneratorModel = SoundGeneratorModel(generatorName: "Sound Generator Model")
        soundGeneratorController.setSoundGenerator(soundGeneratorModel)
        
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.volume , 1.0)
        soundGeneratorController.setVolume(0.333)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.volume , 0.333)
    }
    
    func test_ModfiySoundGeneratorPan() throws {
        
        let soundGeneratorModel = SoundGeneratorModel(generatorName: "Sound Generator Model")
        soundGeneratorController.setSoundGenerator(soundGeneratorModel)
        
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.pan , 0.0)
        soundGeneratorController.setPan(-0.259)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.pan , -0.259)
    }
    

//    func test_VerifySoundGeneratorVolumeLimits() throws {
//        XCTAssertEqual(soundGenerator.volume, 1.0)
//
//        soundGenerator.setVolume(1.00001)
//        XCTAssertEqual(soundGenerator.volume, 1.0)
//
//        soundGenerator.setVolume(-7.0)
//        XCTAssertEqual(soundGenerator.volume, 0.0)
//    }
//
//    func test_VerifySoundGeneratorPanLimits() throws {
//        XCTAssertEqual(soundGenerator.pan, 0.0)
//
//        soundGenerator.setPan(1.00001)
//        XCTAssertEqual(soundGenerator.pan, 1.0)
//
//        soundGenerator.setPan(-1.00001)
//        XCTAssertEqual(soundGenerator.pan, -1.0)
//    }
//
//    func test_LoadSoundSourceforSoundGenerator() throws {
//        soundGenerator.loadSoundSource()
//
//        XCTAssertNotNil(soundGenerator.soundSource)
//    }

    
}

