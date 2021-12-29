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
        let channelCount = 16
        soundEngineManager.createChannels(count: channelCount)
    }

    override func tearDownWithError() throws {
        soundEngineManager.engine.stopEngine()
    }

    func test_createSoundEngineManager() throws {
        let newSoundEngineManager = SoundEngineManager()

        
        XCTAssertNotNil(newSoundEngineManager.engine)
        XCTAssertEqual(newSoundEngineManager.mixerTrackModels.count, 0)
    }
    
    func test_createChannels() throws {
        let newSoundEngineManager = SoundEngineManager()
        
        let channelCount = 16
        newSoundEngineManager.createChannels(count: channelCount)
        
        XCTAssertEqual(newSoundEngineManager.mixerTrackModels.count, channelCount)
        
        for index in 0..<newSoundEngineManager.engine.getChannelCount(){
            XCTAssertEqual(newSoundEngineManager.engine.getChannelName(index)!, "Track \(index)")
        }
    }
    
    func test_muteChannel() throws {
        XCTAssertFalse(soundEngineManager.isChannelMuted(0))
        soundEngineManager.muteChannel(0)
        XCTAssertTrue(soundEngineManager.isChannelMuted(0))
    }
    
    func test_soloChannel() throws {
        for index in 0..<soundEngineManager.engine.getChannelCount(){
            XCTAssertFalse(soundEngineManager.isChannelMuted(index))
        }
        
        soundEngineManager.soloChannel(4)
        XCTAssertFalse(soundEngineManager.isChannelMuted(4))
        for index in 0..<soundEngineManager.engine.getChannelCount(){
            if index == 4 {
                continue
            }
            XCTAssertTrue(soundEngineManager.isChannelMuted(index))
        }
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
