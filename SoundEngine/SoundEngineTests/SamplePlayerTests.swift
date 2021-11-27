//
//  SamplePlayerTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/23/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class SamplePlayerTests: XCTestCase {
    // MARK: Properties
//    let samplePlayer = SamplePlayer(name: "snare", playerNode: AudioPlayerNodeSpy())
    let samplePlayer = SamplePlayer(name: "snare")
    
    // MARK: Tests
    override func setUpWithError() throws {
        samplePlayer.sampleFile = nil
    }
    
    func test_createSamplePlayer(){
        XCTAssertEqual(samplePlayer.name, "snare")
        XCTAssertNotNil(samplePlayer.audioPlayerNode)
        XCTAssertNil(samplePlayer.sampleFile)
    }
    
    func test_setAudioFile(){
        let audioFile = AudioFileSpy().audioFile!
        samplePlayer.setAudioFile(file: audioFile)
        
        XCTAssertEqual(samplePlayer.name, "Heavy Kick.wav")
        XCTAssertEqual(samplePlayer.audioFormat, audioFile.processingFormat)
        XCTAssertEqual(samplePlayer.sampleFile, audioFile)
    }

//    func test_playSample(){
//        samplePlayer.fileScheduled = true
////        XCTAssertEqual(samplePlayer.audioPlayerNode.playCount, 0)
//        
////        samplePlayer.play()
////        XCTAssertEqual(samplePlayer.audioPlayerNode.playCount, 1)
////        XCTAssertEqual(samplePlayer.fileScheduled, false)
//    }
//}




