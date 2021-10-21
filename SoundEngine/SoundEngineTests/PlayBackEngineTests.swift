//
//  PlaybackEngineTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/17/21.
//

import XCTest
import AVFoundation

class PlaybackEngine {
    var audioEngine: AVAudioEngine
    var mixerTracks: [MixerTrack]
    
    init(){
        audioEngine = AVAudioEngine()
        mixerTracks = [MixerTrack]()
    }
    
    func createMixerTrack(){
        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
        mixerTracks.append(mixerTrack)
        audioEngine.attach(mixerTrack.audioMixerNode)
        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
    }
    
    func startEngine() {
        audioEngine.prepare()
        do {
          try audioEngine.start()
        } catch  {
          print("Error starting playback engine: \(error.localizedDescription)")
        }
    }
    
    func stopEngine(){
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
}

class MixerTrack {
    
    var name: String
    var audioMixerNode: AVAudioMixerNode
    
    init(name: String){
        self.name = name
        audioMixerNode = AVAudioMixerNode()
    }
}

class PlaybackEngineTests: XCTestCase {
    // MARK: Properties
    let playbackEngine = PlaybackEngine()
    
    // MARK: Tests
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_CreatePlaybackEngine(){
        let engine = playbackEngine.audioEngine
        
        XCTAssertFalse(engine.isRunning)
        XCTAssertEqual(engine.attachedNodes.count, 0)
        XCTAssertEqual(engine.mainMixerNode.nextAvailableInputBus, 0)
        XCTAssertTrue(playbackEngine.mixerTracks.isEmpty)
    }
    
    func test_CreateMixerTrack(){
        let engine = playbackEngine.audioEngine
        
        XCTAssertTrue(playbackEngine.mixerTracks.isEmpty)

        playbackEngine.createMixerTrack()
        
        XCTAssertEqual(playbackEngine.mixerTracks.count, 1)
        XCTAssertEqual(engine.attachedNodes.count, 3)
        XCTAssertEqual(engine.mainMixerNode.nextAvailableInputBus, 1)
    }
    
    func test_createMultipleMixerTracks(){
        let engine = playbackEngine.audioEngine
        
        XCTAssertTrue(playbackEngine.mixerTracks.isEmpty)

        for _ in 0...9{
            playbackEngine.createMixerTrack()
        }
        
        for i in 0...9{
            XCTAssertTrue(playbackEngine.mixerTracks[i].name == "Track \(i)")
        }
        XCTAssertEqual(playbackEngine.mixerTracks.count, 10)
        XCTAssertEqual(engine.attachedNodes.count, 12)
        XCTAssertEqual(engine.mainMixerNode.nextAvailableInputBus, 10)
    }
    
    func test_StartAudioEngine(){
        let engine = playbackEngine.audioEngine
        
        playbackEngine.createMixerTrack()
        XCTAssertFalse(engine.isRunning)
        
        playbackEngine.startEngine()
        XCTAssertTrue(engine.isRunning)
    }
    
    func test_StopAudioEngine(){
        let engine = playbackEngine.audioEngine
        playbackEngine.createMixerTrack()
        playbackEngine.startEngine()
        
        XCTAssertTrue(engine.isRunning)
        
        playbackEngine.stopEngine()
        XCTAssertFalse(engine.isRunning)
    }
    
}
