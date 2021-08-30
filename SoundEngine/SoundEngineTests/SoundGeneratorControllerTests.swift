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
    
    // MARK: Properties
    let soundGeneratorController = SoundGeneratorController()
    let soundGeneratorModel = SoundGeneratorModel(generatorName: "Sound Generator Model")

    
    // MARK: Tests
    override func setUp() {
        createSUT()
    }
    
    func test_SetSoundGeneratorModelForSoundGeneratorController() throws {
        XCTAssertNotNil(soundGeneratorController.getSoundGenerator())
    }
    
    func test_ModfiySoundGeneratorVolume() throws {
        
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.volume , 1.0)
        soundGeneratorController.setVolume(0.333)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.volume , 0.333)
    }
    
    func test_ModfiySoundGeneratorPan() throws {
        
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.pan , 0.0)
        soundGeneratorController.setPan(-0.259)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.pan , -0.259)
    }
    

    func test_VerifySoundGeneratorVolumeLimits() throws {
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.volume, 1.0)

        soundGeneratorController.setVolume(1.00001)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.volume, 1.0)

        soundGeneratorController.setVolume(-7.0)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.volume, 0.0)
    }

    func test_VerifySoundGeneratorPanLimits() throws {
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.pan, 0.0)

        soundGeneratorController.setPan(1.00001)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.pan, 1.0)

        soundGeneratorController.setPan(-1.00001)
        XCTAssertEqual(soundGeneratorController.getSoundGenerator()?.pan, -1.0)
    }

//    func test_LoadSoundSourceforSoundGenerator() throws {
//        soundGenerator.loadSoundSource()
//
//        XCTAssertNotNil(soundGenerator.soundSource)
//    }

    
// MARK: Helpers
    func createSUT(){
        soundGeneratorController.setSoundGenerator(soundGeneratorModel)
    }
}

