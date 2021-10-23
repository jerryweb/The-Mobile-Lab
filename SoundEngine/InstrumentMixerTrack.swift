//
//  InstrumentMixerTrack.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/21/21.
//

import XCTest
//import AVFoundation
@testable import SoundEngine

class InstrumentMixerTrackTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: Tests
    func test_createInstrumentMixerTrack(){
        let instrumentMixerTrack = InstrumentMixerTrack(name: "Track 1")
        
        XCTAssertFalse(instrumentMixerTrack.muted)
        XCTAssertNotNil(instrumentMixerTrack.audioMixerNode)
        XCTAssertEqual(instrumentMixerTrack.name, "Track 1")
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.volume, 0.5)
    }
    
    func test_muteAndUnmuteInstrumentMixerTrack(){
        let instrumentMixerTrack = InstrumentMixerTrack(name: "Track 1")
        
        instrumentMixerTrack.mute()
        XCTAssertTrue(instrumentMixerTrack.muted)
        
        instrumentMixerTrack.mute()
        XCTAssertFalse(instrumentMixerTrack.muted)
    }
    
    func test_changeVolume(){
        let instrumentMixerTrack = InstrumentMixerTrack(name: "Track 1")
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.volume, 0.5)
        
        instrumentMixerTrack.changeVolume(0.33346)
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.volume, 0.33346)
    }
    
    func test_changePan(){
        let instrumentMixerTrack = InstrumentMixerTrack(name: "Track 1")
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.pan, 0.0)
        
        instrumentMixerTrack.changePan(-0.333)
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.pan, -0.333)
    }
    
    func test_verifyVolumeLimits(){
        let instrumentMixerTrack = InstrumentMixerTrack(name: "Track 1")
        instrumentMixerTrack.changeVolume(-0.05)
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.volume, 0.0)
        
        instrumentMixerTrack.changeVolume(1.00001)
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.volume, 1.0)
    }
    
    func test_verifyPanLimits(){
        let instrumentMixerTrack = InstrumentMixerTrack(name: "Track 1")
        instrumentMixerTrack.changePan(-1.333)
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.pan, -1.0)
        
        instrumentMixerTrack.changePan(1.333)
        XCTAssertEqual(instrumentMixerTrack.audioMixerNode.pan, 1.0)
    }
    
//    func test_playSound(){
//        let instrumentMixerTrack = InstrumentMixerTrack(name: "Track 1")
//
//    }
}
