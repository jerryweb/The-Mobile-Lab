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
        XCTAssertNil(mixerTrack.soundGenerator)
    }
    
    func test_createMixerTrackWithSamplePlayer(){
        let kickSamplePlayer = SamplePlayerSpy(name: "kick")
        let mixerTrack = MixerTrack(name: "Track 1", soundGenerator: kickSamplePlayer)
        
        XCTAssertEqual(mixerTrack.name, "Track 1")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertFalse(mixerTrack.muted)
        XCTAssertEqual(mixerTrack.audioMixerNode.volume, 0.5)
        XCTAssertEqual(mixerTrack.audioMixerNode.pan, 0.0)
        XCTAssertEqual(mixerTrack.soundGenerator?.name, kickSamplePlayer.name)
    }
    
    func test_AddSamplePlayer(){
        let samplePlayerSpy = SamplePlayerSpy(name: "kick sample")
        mixerTrack.setAddSoundGenerator(soundGenerator: samplePlayerSpy)
        
        XCTAssertEqual(mixerTrack.soundGenerator?.name, samplePlayerSpy.name)
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
    
    func test_playSound(){
        let kickSamplePlayer = SamplePlayerSpy(name: "kick")
        let mixerTrack = MixerTrack(name: "Kick Track", soundGenerator: kickSamplePlayer)
        
        mixerTrack.play()
        
        XCTAssertEqual(kickSamplePlayer.playCount, 1)
        
        mixerTrack.mute()
        mixerTrack.play()
        
        XCTAssertEqual(kickSamplePlayer.playCount, 1)
    }
    // MARK: Helpers
    private class SamplePlayerSpy : SoundGenerator {
        var name: String
        var playCount: Int                  // Number of times the sample player's 'play' function is called
        
        init(name: String) {
            self.name = name
            self.playCount = 0
        }
        
        func play() {
            playCount += 1
        }
    }
}
