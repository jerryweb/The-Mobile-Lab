//
//  SamplePlayerTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/23/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

protocol AudioPlayerNode : AVAudioPlayerNode{
    func play()
    func scheduleAudioBuffer()
}

class SamplePlayer : SoundGenerator {
    
    var name: String
    var sampleFile: AudioFile?
    var audioPlayerNode: AudioPlayerNode
    var audioSampleRate: Double = 0
    var audioFormat: AVAudioFormat
    var fileScheduled = false
    
    init(name: String, playerNode: AudioPlayerNode){
        self.name = name
        self.audioPlayerNode = playerNode
        self.audioFormat = AVAudioFormat()
    }

    func setAudioFile(file: AudioFile){
        sampleFile = file 
        name = file.url.lastPathComponent
        audioSampleRate = file.fileFormat.sampleRate
        audioFormat = file.processingFormat
    }
    
    func scheduleFile(){
        guard let file = sampleFile, !fileScheduled else {
            print("No audio file loaded for player \(name)!")
          return
        }

        let audioFrameCount = UInt32(file.length)

        guard let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount) else {
            print("Failed to create audio buffer for player \(name)!")
            return
        }

        do{
            try file.read(into: audioBuffer)
        }
        catch {
            print("Failed to load file into audio buffer")
        }
        
        audioPlayerNode.scheduleBuffer(audioBuffer, at: nil) {
            print(audioBuffer.frameLength)
            self.fileScheduled = true
        }
    }
    
    func play(){
        if let _ = sampleFile {
            if audioPlayerNode.isPlaying {
                audioPlayerNode.stop()
            }
            if !fileScheduled {
                scheduleFile()
            }
            print("play")
            self.audioPlayerNode.play()
            self.fileScheduled = false
        }
    }
}


class SamplePlayerTests: XCTestCase {
    // MARK: Properties
    let samplePlayer = SamplePlayer(name: "snare", playerNode: AudioPlayerNodeSpy())
    let audioFileSpy = AudioFileSpy()
    
    // MARK: Tests
    override func setUpWithError() throws {
        samplePlayer.sampleFile = nil
        samplePlayer.audioSampleRate = 0
    }
    
    func test_createSamplePlayer(){
        XCTAssertEqual(samplePlayer.name, "snare")
        XCTAssertNotNil(samplePlayer.audioPlayerNode)
        XCTAssertNil(samplePlayer.sampleFile)
        XCTAssertEqual(samplePlayer.audioSampleRate, 0)
    }
    
    //
//    func test_createSamplePlayerWithAudioFile(){
//        let kickSamplePlayer = SamplePlayer(file: audioFileSpy.audioFile!)
//
//        XCTAssertEqual(kickSamplePlayer.name, "Heavy Kick.wav")
//        XCTAssertNotNil(kickSamplePlayer.audioPlayerNode)
//        XCTAssertEqual(kickSamplePlayer.sampleFile, audioFileSpy.audioFile)
////        XCTAssertEqual(kickSamplePlayer.audioSampleRate, audioFileSpy.audioFile?.fileFormat.sampleRate)
//    }
//
//    func test_setAudioFile(){
//        let audioFile = audioFileSpy.audioFile!
//        samplePlayer.setAudioFile(file: audioFile)
//
//        XCTAssertFalse(samplePlayer.fileScheduled)
//        XCTAssertEqual(samplePlayer.name, "Heavy Kick.wav")
//        XCTAssertEqual(samplePlayer.sampleFile as? AVAudioFile, audioFile )
//        XCTAssertEqual(samplePlayer.audioSampleRate, audioFile.fileFormat.sampleRate)
//        XCTAssertEqual(samplePlayer.audioFormat, audioFile.processingFormat)
//    }
//
//    func test_playSample(){
//
//        let (mockSoundEngine, audioFileSpy2) = buildSUT()
//
//        XCTAssertTrue(mockSoundEngine.isRunning)
//        samplePlayer.setAudioFile(file: audioFileSpy2.audioFile!)
//        samplePlayer.scheduleFile()
//        self.samplePlayer.play()
//
//    }
    //MARK: Helpers

}




