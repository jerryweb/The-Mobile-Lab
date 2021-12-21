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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
}
