//
//  MixerTrack.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/21/21.
//

import XCTest
@testable import SoundEngine

class MixerTrackTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: Tests
    func test_createMixerTrack(){
        let mixerTrack = MixerTrack(name: "Track 1")
        
        XCTAssertFalse(mixerTrack.muted)
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertEqual(mixerTrack.name, "Track 1")
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.5)
    }
    
    func test_muteAndUnmuteMixerTrack(){
        let mixerTrack = MixerTrack(name: "Track 1")
        
        mixerTrack.mute()
        XCTAssertTrue(mixerTrack.muted)
        
        mixerTrack.mute()
        XCTAssertFalse(mixerTrack.muted)
    }
    
    func test_changeVolume(){
        let mixerTrack = MixerTrack(name: "Track 1")
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.5)
        
        mixerTrack.changeVolume(0.33346)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.33346)
    }
    
    func test_changePan(){
        let mixerTrack = MixerTrack(name: "Track 1")
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 0.0)
        
        mixerTrack.changePan(-0.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, -0.333)
    }
    
    func test_verifyVolumeLimits(){
        let mixerTrack = MixerTrack(name: "Track 1")
        mixerTrack.changeVolume(-0.05)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.0)
        
        mixerTrack.changeVolume(1.00001)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 1.0)
    }
    
    func test_verifyPanLimits(){
        let mixerTrack = MixerTrack(name: "Track 1")
        mixerTrack.changePan(-1.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, -1.0)
        
        mixerTrack.changePan(1.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 1.0)
    }
    
//    func test_playSound(){
//
//    }
}
