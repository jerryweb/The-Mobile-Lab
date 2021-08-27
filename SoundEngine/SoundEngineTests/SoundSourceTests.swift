//
//  SoundSourceTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/26/21.
//

import XCTest
@testable import SoundEngine

class SoundSourceModelTests: XCTestCase {

    func test_CreateDefaultSoundSouceModel() {
        let sampleSoundSource = SoundSourceModel()
        XCTAssertEqual(sampleSoundSource.name, "Sample")
        XCTAssertNil(sampleSoundSource.audioFile)
    }
    
    func test_CreateNewSoundSourceModel() {
        let kickSoundSource = SoundSourceModel(sourceName: "Kick File")
        
        XCTAssertEqual(kickSoundSource.name, "Kick File")
        XCTAssertNil(kickSoundSource.audioFile)
    }
    
    func test_CreateSoundSouceWithAudioFile() {
        let songSoundSource = SoundSourceModel(filePath: "foolishness ext 2", fileExtension: "mp3")
        
        XCTAssertEqual(songSoundSource.name, "foolishness ext 2")
        XCTAssertNotNil(songSoundSource.audioFile)
    }
    
    func test_loadAudioSampleToSoundSourceModel() {
        let sampleSoundSource = SoundSourceModel()
        
        sampleSoundSource.loadSampleFile(filePath: "foolishness ext 2", fileExtension: "mp3")
        XCTAssertNotNil(sampleSoundSource.audioFile)
        
    }

}
