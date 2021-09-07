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
    var playBackEngine = PlayBackEngine()
     
    func test_CreatePlayBackEngine() {
        XCTAssertNotNil(playBackEngine.audioEngine)
    }
    
    func test_CreateAndAttachOneMixerTrack() {
        let mixerTrack = MixerTrackModel()
        
        playBackEngine.audioEngine.attach(mixerTrack.audioMixerNode)
        XCTAssertTrue(playBackEngine.audioEngine.attachedNodes.contains(mixerTrack.audioMixerNode))
    }
    
    func test_CreateAndAttachMultipleMixerTracks() {
        for _ in 0 ..< 10 {
            let mixerTrack = MixerTrackModel()
            playBackEngine.audioEngine.attach(mixerTrack.audioMixerNode)
        }
        
        XCTAssertEqual(playBackEngine.audioEngine.attachedNodes.count, 10)
    }
    
    func test_CreateAndAttachOneSoundGenerator() {
        let soundGenerator = SoundGeneratorModel(generatorName: "Snare")
        
        playBackEngine.audioEngine.attach(soundGenerator.audioPlayerNode)
        XCTAssertTrue(playBackEngine.audioEngine.attachedNodes.contains(soundGenerator.audioPlayerNode))
    }
    
    func test_CreateAndAttachMultipleSoundGenerator() {
        for _ in 0 ..< 10 {
            let soundGenerator = SoundGeneratorModel(generatorName: "Snare")
            playBackEngine.audioEngine.attach(soundGenerator.audioPlayerNode)
        }
        
        XCTAssertEqual(playBackEngine.audioEngine.attachedNodes.count, 10)
    }
    
    func test_Create_And_Attach_MixerTrack_And_SoundGenerator(){
        let soundGenerator = SoundGeneratorModel(generatorName: "Snare")
        let mixerTrack = MixerTrackModel(soundGenerator: soundGenerator)
        
        playBackEngine.audioEngine.attach(mixerTrack.audioMixerNode)
        playBackEngine.audioEngine.attach(soundGenerator.audioPlayerNode)
                
        XCTAssertTrue(playBackEngine.audioEngine.attachedNodes.contains(mixerTrack.audioMixerNode))
        XCTAssertTrue(playBackEngine.audioEngine.attachedNodes.contains(soundGenerator.audioPlayerNode))
    }
}
