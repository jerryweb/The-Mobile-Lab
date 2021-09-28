//
//  PlayBackEngineTests.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class PlayBackEngineTests : XCTestCase {
    // MARK: Properties
    var playBackEngine = PlayBackEngine()
    let soundGenerator = SoundGenerator(generatorName: "Snare")
    let mixerTrack = MixerTrackModel()
    let audioFile = AudioFileSpy()
    
    // MARK: Tests
    func test_CreatePlayBackEngine() {
        XCTAssertEqual(playBackEngine.mixerTracks.count, 0)
        XCTAssertEqual(playBackEngine.soundGenerators.count, 0)
        XCTAssertEqual(playBackEngine.audioEngine.attachedNodes.count, 0)
        XCTAssertNotNil(playBackEngine.audioEngine)
    }
    
    func test_CreateAndAttachOneMixerTrack() {
        playBackEngine.createMixerTrack()
        let mTrack = playBackEngine.mixerTracks[0]
        let aEngine = playBackEngine.audioEngine
        
        XCTAssertTrue(aEngine.attachedNodes.contains(mTrack.audioMixerNode))
        XCTAssertEqual(mTrack.audioMixerNode.engine, playBackEngine.audioEngine)
        XCTAssertEqual(aEngine.attachedNodes.count, 1)
    }
    
    func test_CreateAndAttachMultipleMixerTracks() {
        for _ in 0 ..< 10 {
            playBackEngine.createMixerTrack()
        }
        let mTracks = playBackEngine.mixerTracks
        let aEngine = playBackEngine.audioEngine
        
        XCTAssertEqual(mTracks.count, 10)
        XCTAssertEqual(aEngine.attachedNodes.count, 10)
        for index in 0 ..< 10 {
            XCTAssertTrue(aEngine.attachedNodes.contains(mTracks[index].audioMixerNode))
        }
    }
    
    func test_CreateAndAttachOneSoundGenerator() {
        playBackEngine.audioEngine.attach(soundGenerator.audioPlayerNode)
        XCTAssertTrue(playBackEngine.audioEngine.attachedNodes.contains(soundGenerator.audioPlayerNode))
        XCTAssertEqual(soundGenerator.audioPlayerNode.engine, playBackEngine.audioEngine)
    }
    
    func test_CreateAndAttachMultipleSoundGenerator() {
        for _ in 0 ..< 10 {
            let soundGenerator = SoundGenerator(generatorName: "Snare")
            playBackEngine.audioEngine.attach(soundGenerator.audioPlayerNode)
        }
        
        XCTAssertEqual(playBackEngine.audioEngine.attachedNodes.count, 10)
    }
    
    func test_Create_And_Attach_MixerTrack_And_SoundGenerator(){
        let mixerTrack = MixerTrackModel(soundGenerator: soundGenerator)
        let engine = playBackEngine.audioEngine
        
        engine.attach(mixerTrack.audioMixerNode)
        engine.attach(soundGenerator.audioPlayerNode)
                
        XCTAssertTrue(engine.attachedNodes.contains(mixerTrack.audioMixerNode))
        XCTAssertTrue(engine.attachedNodes.contains(soundGenerator.audioPlayerNode))
    }
    
    func test_Connect_MixerTrack_And_SoundGenerator_Together(){
        let mixerTrack = MixerTrackModel(soundGenerator: soundGenerator)
        
        let engine = playBackEngine.audioEngine
        let mixer = engine.mainMixerNode
        engine.attach(mixerTrack.audioMixerNode)
        engine.attach(soundGenerator.audioPlayerNode)


        XCTAssertEqual(mixer.nextAvailableInputBus, 0)
        XCTAssertEqual(mixerTrack.audioMixerNode.nextAvailableInputBus, 0)
        
        playBackEngine.connectNodes(node: soundGenerator.audioPlayerNode, destinationNode: mixerTrack.audioMixerNode)
        playBackEngine.connectNodes(node: mixerTrack.audioMixerNode, destinationNode: mixer)
        
        XCTAssertEqual(mixer.nextAvailableInputBus, 1)
        XCTAssertEqual(mixerTrack.audioMixerNode.nextAvailableInputBus, 1)
    }
}
