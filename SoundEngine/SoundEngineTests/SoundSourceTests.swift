//
//  SoundSourceTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/26/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class SoundSourceModelTests: XCTestCase {
    let audioSample = AudioFileSpy()

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
        if let audioFile = audioSample.audioFile {
            let songSoundSource = SoundSourceModel(sampleFile: audioFile)
            XCTAssertEqual(songSoundSource.name, "foolishness ext 2.mp3")
            XCTAssertNotNil(audioFile)
        }
        
        else {
            XCTAssertThrowsError("Could not load sound file")
        }
    }
    
    func test_loadAudioSampleToSoundSourceModel() {
        if let audioFile = audioSample.audioFile {
            let sampleSoundSource = SoundSourceModel()
            sampleSoundSource.setAudioSample(audioFile)
            XCTAssertEqual(sampleSoundSource.name, "foolishness ext 2.mp3")
            XCTAssertNotNil(audioFile)
        }
        
        else {
            XCTAssertThrowsError("Could not load sound file")
        }
    }
}
