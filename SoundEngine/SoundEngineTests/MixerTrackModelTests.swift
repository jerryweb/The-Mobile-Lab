//
//  MixerTrackModelTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 9/3/21.
//

import XCTest
@testable import SoundEngine

class MixerTrackModelTests : XCTestCase {
    
    func test_CreateDefaultMixerTrack() {
        let mixerTrack = MixerTrackModel()
        
        XCTAssertEqual(mixerTrack.name, "track 1")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertNil(mixerTrack.soundGenerator)
    }
    
    func test_CreateMixerTrackWithGivenName() {
        let mixerTrack = MixerTrackModel(name: "Kick Track")
        
        XCTAssertEqual(mixerTrack.name, "Kick Track")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertNil(mixerTrack.soundGenerator)
    }
    
    func test_CreateMixerTrackWithSoundGenerator() {
        let soundGenerator = SoundGeneratorModel(generatorName: "Piano")
        let mixerTrack = MixerTrackModel(soundGenerator: soundGenerator)
        
        XCTAssertEqual(mixerTrack.name, "Piano")
        XCTAssertNotNil(mixerTrack.audioMixerNode)
        XCTAssertEqual(mixerTrack.soundGenerator?.name, soundGenerator.name)
    }
    
    
}
