//
//  PlaybackEngineTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/17/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class PlaybackEngine {
    var audioEngine: AVAudioEngine
    var mixerTracks: [Track]
    var soundGenerators: [SoundGenerator]
    
    init(){
        audioEngine = AVAudioEngine()
        mixerTracks = [Track]()
        soundGenerators = [SoundGenerator]()
    }
    
    func createMixerTrack(){
        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
        mixerTracks.append(mixerTrack)
        audioEngine.attach(mixerTrack.audioMixerNode)
        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
    }
    
    func createChannel(playerNode: AudioPlayerNode){
        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
        let samplePlayer = SamplePlayer(name: "Sample \(String(self.soundGenerators.count))", playerNode: playerNode)
        
        mixerTracks.append(mixerTrack)
        audioEngine.attach(mixerTrack.audioMixerNode)
        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
        
        soundGenerators.append(samplePlayer)
        audioEngine.attach(samplePlayer.audioPlayerNode)
        audioEngine.connect(samplePlayer.audioPlayerNode, to: mixerTrack.audioMixerNode, format: samplePlayer.audioPlayerNode.outputFormat(forBus: 0))
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


class PlaybackEngineTests: XCTestCase {
    // MARK: Properties
    let playbackEngine = PlaybackEngine()
    var engine = AVAudioEngine()
    let audioFileSpy = AudioFileSpy()

    
    // MARK: Tests
    override func setUpWithError() throws {
        engine = playbackEngine.audioEngine
    }
    
    func test_createPlaybackEngine(){
        XCTAssertTrue(playbackEngine.mixerTracks.isEmpty)
        XCTAssertTrue(playbackEngine.soundGenerators.isEmpty)
        XCTAssertFalse(engine.isRunning)
        expect(pEngine: playbackEngine, trackCount: 0, soundGeneratorCount: 0, nodeCount: 0, nextInputBus: 0, when: {})
    }
    
    func test_createMixerTrack(){
        playbackEngine.createMixerTrack()
        XCTAssertEqual(playbackEngine.mixerTracks.count, 1)
    }
    
    func test_createChannel(){
        playbackEngine.createChannel(playerNode: AudioPlayerNodeSpy())
        XCTAssertEqual(playbackEngine.mixerTracks.count, 1)
        XCTAssertEqual(playbackEngine.soundGenerators.count, 1)
    }

    func test_createMultipleChannels(){
        expect(pEngine: playbackEngine, trackCount: 16, soundGeneratorCount: 16, nodeCount: 34, nextInputBus: 16, when: {
            for _ in 0...15{
                playbackEngine.createChannel(playerNode: AudioPlayerNodeSpy())
            }
        })
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
    
    // MARK: Helpers
    private func expect(pEngine: PlaybackEngine, trackCount: Int, soundGeneratorCount: Int, nodeCount: Int, nextInputBus: Int, when action: () -> Void, file: StaticString = #file, line: UInt = #line){
        
        action()
        
        XCTAssertEqual(pEngine.mixerTracks.count, trackCount)
        XCTAssertEqual(pEngine.soundGenerators.count, soundGeneratorCount)
        XCTAssertEqual(pEngine.audioEngine.attachedNodes.count, nodeCount)
        XCTAssertEqual(pEngine.audioEngine.mainMixerNode.nextAvailableInputBus, nextInputBus)
    }
    
    // Mocked MixerTrack Class to allow for easy testing
//    private class MixerTrackSpy : Track{
//        var muted: Bool
//        var audioMixerNode: AVAudioMixerNode
//        var isPlaying: [Bool]
//        var name: String
//        
//        init(name: String){
//            self.name = name
//            self.muted = false
//            self.audioMixerNode = AVAudioMixerNode()
//            isPlaying = [Bool]()
//        }
//        
//        func play() {
//            if !muted { isPlaying.append(true) }
//            else { isPlaying.append(false) }
//        }
//    }
}

//extension XCTestCase {
//     func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
//        addTeardownBlock { [weak instance] in
//            XCTAssertNil(instance, "Instance should have been deallocate. Potential memory leak.", file: file, line: line)
//        }
//
//    }
//}
