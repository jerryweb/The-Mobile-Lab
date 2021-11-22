//
//  MixerTrack.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/21/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine



class MixerTrackTests: XCTestCase {
    // MARK: Properties
    let mixerTrack = MixerTrack(name: "Track 1")
    
    // MARK: Tests
    func test_createMixerTrackWithoutSamplePlayer(){
        XCTAssertEqual(mixerTrack.name, "Track 1")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertFalse(mixerTrack.muted)
        XCTAssertEqual(mixerTrack.audioMixerNode.outputVolume, 0.5)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 1.0)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 0.0)
    }
    
    func test_muteAndUnmuteMixerTrack(){
        mixerTrack.mute()
        XCTAssertTrue(mixerTrack.muted)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0)
        
        mixerTrack.mute()
        XCTAssertFalse(mixerTrack.muted)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 1.0)
    }
    
    func test_changeVolume(){
        mixerTrack.changeVolume(0.33346)
        XCTAssertEqual(mixerTrack.audioMixerNode.outputVolume, 0.33346)
    }
    
    func test_changePan(){
        mixerTrack.changePan(-0.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, -0.333)
    }
    
    func test_verifyVolumeLimits(){
        mixerTrack.changeVolume(-0.05)
        XCTAssertEqual(mixerTrack.audioMixerNode.outputVolume, 0.0)
        
        mixerTrack.changeVolume(1.03001)
        XCTAssertEqual(mixerTrack.audioMixerNode.outputVolume, 1.0)
    }
    
    func test_verifyPanLimits(){
        mixerTrack.changePan(-1.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, -1.0)
        
        mixerTrack.changePan(1.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 1.0)
    }
    
    func test_solo(){
        mixerTrack.solo()
        XCTAssertTrue(mixerTrack.soloActive)
    }
    
    func test_soloWhileMuted() {
        mixerTrack.mute()
        mixerTrack.solo()
        XCTAssertTrue(mixerTrack.soloActive)
        XCTAssertFalse(mixerTrack.muted)
    }
}
