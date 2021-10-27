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
//        XCTAssertEqual(kickSamplePlayer.audioSampleRate, audioFileSpy.audioFile?.fileFormat.sampleRate)
    }
    
    func test_setAudioFile(){
        let audioFile = audioFileSpy.audioFile!
        samplePlayer.setAudioFile(file: audioFile)
        
        XCTAssertFalse(samplePlayer.fileScheduled)
        XCTAssertEqual(samplePlayer.name, "Heavy Kick.wav")
        XCTAssertEqual(samplePlayer.sampleFile as? AVAudioFile, audioFile )
        XCTAssertEqual(samplePlayer.audioSampleRate, audioFile.fileFormat.sampleRate)
        XCTAssertEqual(samplePlayer.audioFormat, audioFile.processingFormat)
    }
    
    func test_playSample(){
        
        let (mockSoundEngine, audioFileSpy2) = buildSUT()
        
        XCTAssertTrue(mockSoundEngine.isRunning)
        samplePlayer.setAudioFile(file: audioFileSpy2.audioFile!)
        samplePlayer.scheduleFile()
        self.samplePlayer.play()

    }
    
    
    private func buildSUT() -> (AVAudioEngine, AudioFileSpy){
        let audioFileSpy2 = AudioFileSpy()
        let audioFile = audioFileSpy2.audioFile!
        
        
        let mockSoundEngine = AVAudioEngine()
        mockSoundEngine.attach(samplePlayer.audioPlayerNode)
        mockSoundEngine.connect(samplePlayer.audioPlayerNode, to: mockSoundEngine.mainMixerNode, format: audioFile.processingFormat)
        mockSoundEngine.prepare()
        
        do{
            try mockSoundEngine.start()
        } catch {
            XCTFail("Failed to start sound engine")
        }
        
        return (mockSoundEngine, audioFileSpy2)
    }
}
