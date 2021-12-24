//
//  SoundEngineManagerTests.swift
//  MobileLabTests
//
//  Created by Jerry on 12/13/21.
//

import XCTest
@testable import MobileLab

class SoundEngineManagerTests: XCTestCase {

    var soundEngineManager = SoundEngineManager()
    
    override func setUpWithError() throws {
        soundEngineManager = SoundEngineManager()
        soundEngineManager.engine.startEngine()
    }

    override func tearDownWithError() throws {
        soundEngineManager.engine.stopEngine()
    }

    func test_createSoundEngineManager() throws {
        
        XCTAssertNotNil(soundEngineManager.engine)
        XCTAssertEqual(soundEngineManager.mixerTrackModels.count, 16)
        
        for index in 0..<soundEngineManager.engine.getChannelCount(){
            XCTAssertEqual(soundEngineManager.engine.getChannelName(index)!, "Track \(index)")
        }
    }
    
    func test_muteChannel() throws {
        XCTAssertFalse(soundEngineManager.isChannelMuted(0))
        soundEngineManager.muteChannel(0)
        XCTAssertTrue(soundEngineManager.isChannelMuted(0))
    }
    
    func test_changeMasterVolume() throws {
        XCTAssertEqual(soundEngineManager.getMasterVolume(), 1.0)
        soundEngineManager.setMasterVolume(0.222)
        XCTAssertEqual(soundEngineManager.getMasterVolume(), 0.222)
    }
    
    func test_getChannelName() throws {
        XCTAssertEqual(soundEngineManager.getChannelName(5), "Track 5")
    }
    
    func test_changeChannelPan() throws {
        XCTAssertEqual(soundEngineManager.engine.getChannelPan(4), 0.0)
        soundEngineManager.engine.setChannelPan(channel: 4, pan: -0.7)
        XCTAssertEqual(soundEngineManager.engine.getChannelPan(4), -0.7)
    }
    
    func test_changeChannelVolume() throws {
        XCTAssertEqual(soundEngineManager.engine.getChannelOutputVolume(4), 1.0)
        soundEngineManager.engine.setChannelOutputVolume(channel: 4, vol: 0.123)
        XCTAssertEqual(soundEngineManager.engine.getChannelOutputVolume(4), 0.123)
    }
    
}
