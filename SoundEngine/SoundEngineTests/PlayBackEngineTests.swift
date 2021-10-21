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
    
    func deleteMixerTrack(trackNumber: Int){
        if trackNumber >= 0 && trackNumber < mixerTracks.count {
            audioEngine.detach(mixerTracks[trackNumber].audioMixerNode)
            mixerTracks.remove(at: trackNumber)
        }
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
    
    deinit {
        print("Mixer track \(name) has been deinitialized.")
    }
}

class PlaybackEngineTests: XCTestCase {
    // MARK: Properties
    let playbackEngine = PlaybackEngine()
    var engine = AVAudioEngine()
    
    // MARK: Tests
    override func setUpWithError() throws {
        engine = playbackEngine.audioEngine
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_createPlaybackEngine(){
        XCTAssertFalse(engine.isRunning)
        XCTAssertEqual(engine.attachedNodes.count, 0)
        XCTAssertEqual(engine.mainMixerNode.nextAvailableInputBus, 0)
        XCTAssertTrue(playbackEngine.mixerTracks.isEmpty)
    }
    
    func test_createMixerTrack(){
        XCTAssertTrue(playbackEngine.mixerTracks.isEmpty)

        playbackEngine.createMixerTrack()
        
        XCTAssertEqual(playbackEngine.mixerTracks.count, 1)
        XCTAssertEqual(engine.attachedNodes.count, 3)
        XCTAssertEqual(engine.mainMixerNode.nextAvailableInputBus, 1)
    }
    
    func test_createMultipleMixerTracks(){
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
    
    func test_deleteMixerTrack(){
        playbackEngine.createMixerTrack()
        playbackEngine.createMixerTrack()
        
        XCTAssertEqual(playbackEngine.mixerTracks.count, 2)
        XCTAssertEqual(engine.attachedNodes.count, 4)
        XCTAssertEqual(engine.mainMixerNode.nextAvailableInputBus, 2)
        
        playbackEngine.deleteMixerTrack(trackNumber: 0)
        
        XCTAssertEqual(playbackEngine.mixerTracks.count, 1)
        XCTAssertEqual(engine.attachedNodes.count, 3)
        XCTAssertEqual(engine.mainMixerNode.nextAvailableInputBus, 0)
    }
    
    func test_startAudioEngine(){
        playbackEngine.createMixerTrack()
        XCTAssertFalse(engine.isRunning)
        
        playbackEngine.startEngine()
        XCTAssertTrue(engine.isRunning)
    }
    
    func test_stopAudioEngine(){
        playbackEngine.createMixerTrack()
        playbackEngine.startEngine()
        
        XCTAssertTrue(engine.isRunning)
        
        playbackEngine.stopEngine()
        XCTAssertFalse(engine.isRunning)
    }
    
}
