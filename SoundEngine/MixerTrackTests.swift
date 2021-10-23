//
//  MixerTrack.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/21/21.
//

import XCTest
@testable import SoundEngine

class MixerTrackTests: XCTestCase {
    let mixerTrack = MixerTrack(name: "Track 1")
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: Tests
    func test_createMixerTrackWithoutSamplePlayer(){
        XCTAssertEqual(mixerTrack.name, "Track 1")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertFalse(mixerTrack.muted)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.5)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 0.0)
        XCTAssertNil(mixerTrack.samplePlayer)
    }
    
    func test_createMixerTrackWithSamplePlayer(){
        let kickSamplePlayer = SamplePlayer(name: "kick")
        let mixerTrack = MixerTrack(name: "Track 1", samplePlayer: kickSamplePlayer)
        
        XCTAssertEqual(mixerTrack.name, "Track 1")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertFalse(mixerTrack.muted)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.5)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 0.0)
        XCTAssertEqual(mixerTrack.samplePlayer?.name, kickSamplePlayer.name)
    }
    
    func test_muteAndUnmuteMixerTrack(){
        mixerTrack.mute()
        XCTAssertTrue(mixerTrack.muted)
        
        mixerTrack.mute()
        XCTAssertFalse(mixerTrack.muted)
    }
    
    func test_changeVolume(){
        mixerTrack.changeVolume(0.33346)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.33346)
    }
    
    func test_changePan(){
        mixerTrack.changePan(-0.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, -0.333)
    }
    
    func test_verifyVolumeLimits(){
        mixerTrack.changeVolume(-0.05)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.0)
        
        mixerTrack.changeVolume(1.00001)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 1.0)
    }
    
    func test_verifyPanLimits(){
        mixerTrack.changePan(-1.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, -1.0)
        
        mixerTrack.changePan(1.333)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 1.0)
    }
    
//    func test_playSound(){
//
//    }
}
