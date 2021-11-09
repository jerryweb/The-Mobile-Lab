//
//  PlaybackEngineTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/17/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class PlaybackEngineTests: XCTestCase {
    // MARK: Properties
    let playbackEngine = PlaybackEngine()
    var engine = AVAudioEngine()
    let audioFileSpy = AudioFileSpy()

    
    // MARK: Tests
    override func setUpWithError() throws {
        engine = playbackEngine.audioEngine
        let mixerTrackSpy = MixerTrackSpy(name: "mixer track spy")
        let samplePlayerSpy = SamplePlayerSpy(name: "sample player spy")
        playbackEngine.mixerTracks.append(mixerTrackSpy)
        playbackEngine.soundGenerators.append(samplePlayerSpy)
    }
    
    override func tearDownWithError() throws {
        playbackEngine.mixerTracks.removeAll()
        playbackEngine.soundGenerators.removeAll()
    }
    
    func test_createPlaybackEngine(){
        let newPlaybackEngine = PlaybackEngine()
        
        XCTAssertTrue(newPlaybackEngine.mixerTracks.isEmpty)
        XCTAssertTrue(newPlaybackEngine.soundGenerators.isEmpty)
        XCTAssertFalse(engine.isRunning)
        XCTAssertNotNil(newPlaybackEngine.stepSequencer)
        XCTAssertEqual(newPlaybackEngine.stepSequencer.maxNumberOfTracks, 16)
        XCTAssertEqual(newPlaybackEngine.stepSequencer.numberOfBars, 4)
        expect(pEngine: newPlaybackEngine, trackCount: 0, soundGeneratorCount: 0, nodeCount: 0, nextInputBus: 0, when: {})
    }

    func test_createChannel(){
        let newPlaybackEngine = PlaybackEngine()
        newPlaybackEngine.createChannel(playerNode: AudioPlayerNodeSpy())
        XCTAssertEqual(newPlaybackEngine.mixerTracks.count, 1)
        XCTAssertEqual(newPlaybackEngine.soundGenerators.count, 1)
    }

    func test_createMultipleChannels(){
        let newPlaybackEngine = PlaybackEngine()
        
        expect(pEngine: newPlaybackEngine, trackCount: 16, soundGeneratorCount: 16, nodeCount: 34, nextInputBus: 16, when: {
            for _ in 0...15{
                newPlaybackEngine.createChannel(playerNode: AudioPlayerNodeSpy())
            }
        })
    }
    
//    func test_startAudioEngine(){
//        let newPlaybackEngine = PlaybackEngine()
//        XCTAssertFalse(newPlaybackEngine.audioEngine.isRunning)
//
//        playbackEngine.startEngine()
//        XCTAssertTrue(newPlaybackEngine.audioEngine.isRunning)
//    }
//
//    func test_stopAudioEngine(){
//        let newPlaybackEngine = PlaybackEngine()
//        playbackEngine.startEngine()
//
//        XCTAssertTrue(engine.isRunning)
//
//        playbackEngine.stopEngine()
//        XCTAssertFalse(engine.isRunning)
//    }
    
    func test_loadSampleAudioFileIntoChannel() {
        let audioFile = audioFileSpy.audioFile!
        playbackEngine.loadAudioFile(channel: 0, audioFile: audioFile)
        
        XCTAssertEqual((playbackEngine.soundGenerators[0] as! SamplePlayerSpy).file, audioFile)
    }
    
    func test_playChannel(){
        playbackEngine.playChannel(channel: 0)
        
        XCTAssertEqual((playbackEngine.soundGenerators[0] as! SamplePlayerSpy).playCount, 1)
        XCTAssertFalse((playbackEngine.soundGenerators[0] as! SamplePlayerSpy).fileScheduled)
    }
    
    func test_muteChannel(){
        playbackEngine.muteChannel(channel: 0)
        XCTAssertTrue(playbackEngine.mixerTracks[0].muted)
        
        playbackEngine.muteChannel(channel: 0)
        XCTAssertFalse(playbackEngine.mixerTracks[0].muted)
    }
    
    func test_soloChannel(){
        for _ in 0...2 {
            let mixerTrackSpy = MixerTrackSpy(name: "mixer track spy")
            playbackEngine.mixerTracks.append(mixerTrackSpy)
        }
        
        playbackEngine.soloChannel(channel: 1)
        
        XCTAssertFalse(playbackEngine.mixerTracks[1].muted)
        XCTAssertTrue(playbackEngine.mixerTracks[0].muted)
        XCTAssertTrue(playbackEngine.mixerTracks[2].muted)
        
        playbackEngine.soloChannel(channel: 1)
        XCTAssertFalse(playbackEngine.mixerTracks[1].muted)
        XCTAssertFalse(playbackEngine.mixerTracks[0].muted)
        XCTAssertFalse(playbackEngine.mixerTracks[2].muted)
    }
    
    func test_triggerStep(){
        playbackEngine.toggleSequenceStep(track: 6, beat: 12)
        XCTAssertTrue(playbackEngine.stepSequencer.steps[6][12])
        
        playbackEngine.toggleSequenceStep(track: 6, beat: 12)
        XCTAssertFalse(playbackEngine.stepSequencer.steps[6][12])
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
    private class MixerTrackSpy : Track{
        
        
        var soloActive: Bool
        var muted: Bool
        var audioMixerNode: AVAudioMixerNode
        var isPlaying: [Bool]
        var name: String
        
        init(name: String){
            self.name = name
            muted = false
            audioMixerNode = AVAudioMixerNode()
            isPlaying = [Bool]()
            soloActive = false
        }
        func mute() {
            muted = !muted
        }
        
        func solo() {
            soloActive = !soloActive
        }
        
    }
    
    private class SamplePlayerSpy : SoundGenerator {
        
        var name: String
        var playCount: Int
        var fileScheduled: Bool
        var file: AVAudioFile?
        
        init(name: String){
            self.name = name
            playCount = 0
            fileScheduled = false
        }
        
        func play() {
            playCount += 1
            fileScheduled = false
        }
        
        func scheduleFile() {
            fileScheduled = true
        }
        
        func setAudioFile(file: AVAudioFile) {
            self.file = file
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
