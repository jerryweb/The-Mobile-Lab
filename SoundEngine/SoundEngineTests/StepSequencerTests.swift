//
//  StepSequencerTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 11/6/21.
//

import XCTest
@testable import SoundEngine

class StepSequencerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func test_createDefaultStepSequencer() {
        let stepSequencer = StepSequencer()
        let numberOfTracks = 16
        let numberOfBars = 4
        let timeSignature = 4
        let beatsPerMinute = 90
        
        XCTAssertEqual(stepSequencer.maxNumberOfTracks, numberOfTracks)
        XCTAssertEqual(stepSequencer.numberOfBars, numberOfBars)
        XCTAssertEqual(stepSequencer.timeSignature, timeSignature)
        XCTAssertEqual(stepSequencer.beatsPerMinute, beatsPerMinute)
        for step in stepSequencer.steps {
            XCTAssertFalse(step.contains(true))
        }
    }
    
    func test_createCustomStepSequencer(){
        let customStepSequencer = StepSequencer(numberOfBars: 10, timeSignature: 3, maxNumberOfTracks: 7, bpm: 90)
        
        XCTAssertEqual(customStepSequencer.maxNumberOfTracks, 7)
        XCTAssertEqual(customStepSequencer.numberOfBars, 10)
        XCTAssertEqual(customStepSequencer.timeSignature, 3)
        XCTAssertEqual(customStepSequencer.beatsPerMinute, 90)
        XCTAssertEqual(customStepSequencer.steps.count, 7)
        XCTAssertEqual(customStepSequencer.steps[0].count, 30)
        for step in customStepSequencer.steps {
            XCTAssertFalse(step.contains(true))
        }
    }
    
    func test_toggleStep(){
        let stepSequencer = StepSequencer()
        let track = 4
        let beat = 12
        
        stepSequencer.toggleStep(track: track, beat: beat)
        XCTAssertEqual(stepSequencer.steps[track][beat], true)
        
        stepSequencer.toggleStep(track: track, beat: beat)
        XCTAssertEqual(stepSequencer.steps[track][beat], false)
    }
    
    func test_verifyNoChangeIfTrackOrBeatOutOfRange(){
        let stepSequencer = StepSequencer()
        let track = 17
        let beat = -1
        
        stepSequencer.toggleStep(track: track, beat: beat)
        for step in stepSequencer.steps {
            XCTAssertFalse(step.contains(true))
        }
    }
}
