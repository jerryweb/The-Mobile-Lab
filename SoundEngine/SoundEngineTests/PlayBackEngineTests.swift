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
    var channels: [(Track, SoundGenerator)]
//    var mixerTracks: [Track]
//    var samplePlayers: [SoundGenerator]
    
    init(){
        audioEngine = AVAudioEngine()
        channels = [(Track, SoundGenerator)]()
    }
    
    func createChannel(){
        let mixerTrack = MixerTrack(name: "Track \(String(self.channels.count))")
        let samplePlayer = SamplePlayer(name: "Sample \(String(self.channels.count))")
        
        channels.append((mixerTrack, samplePlayer))
        audioEngine.attach(mixerTrack.audioMixerNode)
        audioEngine.attach(samplePlayer.audioPlayerNode)
        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
        audioEngine.connect(samplePlayer.audioPlayerNode, to: mixerTrack.audioMixerNode, format: samplePlayer.audioPlayerNode.outputFormat(forBus: 0))
    }
//
//    func deleteMixerTrack(trackNumber: Int){
//        if trackNumber >= 0 && trackNumber < mixerTracks.count {
//            audioEngine.disconnectNodeOutput(mixerTracks[trackNumber].audioMixerNode)
//            audioEngine.disconnectNodeInput(mixerTracks[trackNumber].audioMixerNode)
//            audioEngine.detach(mixerTracks[trackNumber].audioMixerNode)
//
//            mixerTracks.remove(at: trackNumber)
//        }
//    }
//
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
    
//    func playTrack(trackNumber: Int){
//        if trackNumber >= 0 && trackNumber < mixerTracks.count {
//            mixerTracks[trackNumber].play()
//        }
//    }
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
        XCTAssertTrue(playbackEngine.channels.isEmpty)
        XCTAssertFalse(engine.isRunning)
        expect(pEngine: playbackEngine, trackCount: 0, nodeCount: 0, nextInputBus: 0, when: {})
    }
    
    func test_createChannelStrip(){
        playbackEngine.createChannel()
        XCTAssertEqual(playbackEngine.channels.count, 1)
    }

    func test_createMultipleChannelStrips(){
        expect(pEngine: playbackEngine, trackCount: 10, nodeCount: 22, nextInputBus: 10, when: {
            for _ in 0...9{
                playbackEngine.createChannel()
            }
        })
    }

//    func test_deleteMixerTrack(){
//        expect(pEngine: playbackEngine, trackCount: 2, nodeCount: 4, nextInputBus: 2, when: {
//            playbackEngine.createMixerTrack()
//            playbackEngine.createMixerTrack()
//        })
//
//        expect(pEngine: playbackEngine, trackCount: 1, nodeCount: 3, nextInputBus: 0, when: {
//            playbackEngine.deleteMixerTrack(trackNumber: 0)
//        })
//    }
    
//    func test_startAudioEngine(){
//        playbackEngine.createMixerTrack()
//        XCTAssertFalse(engine.isRunning)
//
//        playbackEngine.startEngine()
//        XCTAssertTrue(engine.isRunning)
//    }
//
//    func test_stopAudioEngine(){
//        playbackEngine.createMixerTrack()
//        playbackEngine.startEngine()
//
//        XCTAssertTrue(engine.isRunning)
//
//        playbackEngine.stopEngine()
//        XCTAssertFalse(engine.isRunning)
//    }
    
//    func test_playMixerTrack(){
//        let mixerTrackSpy = MixerTrackSpy(name: "track 0")
//        playbackEngine.mixerTracks.append(mixerTrackSpy)
//        engine.attach(mixerTrackSpy.audioMixerNode)
//
//        XCTAssertTrue(mixerTrackSpy.isPlaying.isEmpty)
//
//        playbackEngine.playTrack(trackNumber: 0)
//        playbackEngine.playTrack(trackNumber: 0)
//        XCTAssertEqual(mixerTrackSpy.isPlaying, [true, true])
//    }
    
    // MARK: Helpers
    private func expect(pEngine: PlaybackEngine, trackCount: Int, nodeCount: Int, nextInputBus: Int, when action: () -> Void, file: StaticString = #file, line: UInt = #line){
        
        action()
        
        XCTAssertEqual(pEngine.channels.count, trackCount)
        XCTAssertEqual(pEngine.audioEngine.attachedNodes.count, nodeCount)
        XCTAssertEqual(pEngine.audioEngine.mainMixerNode.nextAvailableInputBus, nextInputBus)
    }
    
    // Mocked MixerTrack Class to allow for easy testing
    private class MixerTrackSpy : Track{
        var muted: Bool
        var audioMixerNode: AVAudioMixerNode
        var isPlaying: [Bool]
        var name: String
        
        init(name: String){
            self.name = name
            self.muted = false
            self.audioMixerNode = AVAudioMixerNode()
            isPlaying = [Bool]()
        }
        
        func play() {
            if !muted { isPlaying.append(true) }
            else { isPlaying.append(false) }
        }
    }
}

//extension XCTestCase {
//     func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
//        addTeardownBlock { [weak instance] in
//            XCTAssertNil(instance, "Instance should have been deallocate. Potential memory leak.", file: file, line: line)
//        }
//
//    }
//}
