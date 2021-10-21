//
//  PlaybackEngineTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/17/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class PlaybackEngineTests: XCTestCase {
    // MARK: Properties
    let playbackEngine = PlaybackEngine()
    var engine = AVAudioEngine()
    
    // MARK: Tests
    override func setUpWithError() throws {
        engine = playbackEngine.audioEngine
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_createPlaybackEngine(){
        XCTAssertFalse(engine.isRunning)
        expect(pEngine: playbackEngine, trackCount: 0, nodeCount: 0, nextInputBus: 0, when: {})
    }
    
    func test_createMixerTrack(){
        expect(pEngine: playbackEngine, trackCount: 1, nodeCount: 3, nextInputBus: 1, when: {
            playbackEngine.createMixerTrack()
        })
    }
    
    func test_createMultipleMixerTracks(){
        expect(pEngine: playbackEngine, trackCount: 10, nodeCount: 12, nextInputBus: 10, when: {
            for _ in 0...9{
                playbackEngine.createMixerTrack()
            }
        })
    }

    func test_deleteMixerTrack(){
        expect(pEngine: playbackEngine, trackCount: 2, nodeCount: 4, nextInputBus: 2, when: {
            playbackEngine.createMixerTrack()
            playbackEngine.createMixerTrack()
        })
        
        expect(pEngine: playbackEngine, trackCount: 1, nodeCount: 3, nextInputBus: 0, when: {
            playbackEngine.deleteMixerTrack(trackNumber: 0)
        })
        
    }
    
    func test_startAudioEngine(){
        playbackEngine.createMixerTrack()
        XCTAssertFalse(engine.isRunning)
        
        playbackEngine.startEngine()
        XCTAssertTrue(engine.isRunning)
    }
    
    func test_stopAudioEngine(){
        playbackEngine.createMixerTrack()
        playbackEngine.startEngine()
        
        XCTAssertTrue(engine.isRunning)
        
        playbackEngine.stopEngine()
        XCTAssertFalse(engine.isRunning)
    }
    
    // MARK: Helpers
    private func expect(pEngine: PlaybackEngine, trackCount: Int, nodeCount: Int, nextInputBus: Int, when action: () -> Void, file: StaticString = #file, line: UInt = #line){
        
        action()
        
        XCTAssertEqual(pEngine.mixerTracks.count, trackCount)
        XCTAssertEqual(pEngine.audioEngine.attachedNodes.count, nodeCount)
        XCTAssertEqual(pEngine.audioEngine.mainMixerNode.nextAvailableInputBus, nextInputBus)
    }
    
}

extension XCTestCase {
     func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocate. Potential memory leak.", file: file, line: line)
        }
        
    }
}
