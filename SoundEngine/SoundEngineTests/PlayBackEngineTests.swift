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
    
    func test_Create_PlayBack_Engine() {
        let playBackEngine = PlayBackEngine()
        XCTAssertNotNil(playBackEngine.audioEngine)
    }
    
    func test_Create_And_Attach_Audio_Mixer_Node() {
        let playBackEngine = PlayBackEngine()
        let mixerTrack = MixerTrackModel()
        
        playBackEngine.audioEngine.attach(mixerTrack.audioMixerNode)
        XCTAssertEqual(playBackEngine.audioEngine.attachedNodes.first, mixerTrack.audioMixerNode)
    }
}
