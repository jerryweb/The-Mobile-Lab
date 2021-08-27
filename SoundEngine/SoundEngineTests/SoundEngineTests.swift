//
//  SoundEngineTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/26/21.
//

import XCTest
@testable import SoundEngine

class SoundEngineTests: XCTestCase {
    let soundGenerator = SoundGeneratorModel(generatorName: nil)
    
    func test_CreateNewSoundGenerator_withGivenName() throws {
        let kickSoundGenerator = SoundGeneratorModel(generatorName: "Kick")

        XCTAssertEqual(kickSoundGenerator.name, "Kick")
    }
    
    
    func test_CreateNewSoundGenerator_verifyDefaultValues() throws {
                
        XCTAssertEqual(soundGenerator.name, "Sample")
        XCTAssertEqual(soundGenerator.volume, 1.0)
        XCTAssertEqual(soundGenerator.pan, 0.0)
        XCTAssertNil(soundGenerator.audioFile)
    }
    
    func test_LoadSoundSampleFile() throws {
        soundGenerator.loadSample(filePath: "foolishness ext 2", fileExtension: "mp3")
        
        XCTAssertNotNil(soundGenerator.audioFile)
    }
    
    

}
