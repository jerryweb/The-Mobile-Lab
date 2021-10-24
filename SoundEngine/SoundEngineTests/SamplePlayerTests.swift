//
//  SamplePlayerTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/23/21.
//

import XCTest
@testable import SoundEngine

class SamplePlayerTests: XCTestCase {
    // MARK: Properties
    let samplePlayer = SamplePlayer(name: "snare")
    let audioFileSpy = AudioFileSpy()
    
    // MARK: Tests
    func test_createSamplePlayer(){
        XCTAssertEqual(samplePlayer.name, "snare")
        XCTAssertNotNil(samplePlayer.audioPlayerNode)
        XCTAssertNil(samplePlayer.sampleFile)
        XCTAssertEqual(samplePlayer.audioSampleRate, 0)
    }
    
    func test_createSamplePlayerWithAudioFile(){
        let kickSamplePlayer = SamplePlayer(file: audioFileSpy.audioFile!)
            
        XCTAssertEqual(kickSamplePlayer.name, "Heavy Kick.wav")
        XCTAssertNotNil(kickSamplePlayer.audioPlayerNode)
        XCTAssertEqual(kickSamplePlayer.sampleFile, audioFileSpy.audioFile)
        XCTAssertEqual(kickSamplePlayer.audioSampleRate, audioFileSpy.audioFile?.fileFormat.sampleRate)
    }
    
    func test_setAudioFile(){
        let audioFile = audioFileSpy.audioFile!
        samplePlayer.setAudioFile(file: audioFile)
        
        XCTAssertEqual(samplePlayer.name, "Heavy Kick.wav")
        XCTAssertEqual(samplePlayer.sampleFile, audioFile)
        XCTAssertEqual(samplePlayer.audioSampleRate, audioFile.fileFormat.sampleRate)
    }
}
