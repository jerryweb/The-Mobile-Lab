//
//  StepSequencerTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 11/6/21.
//

import XCTest


class StepSequencer {
    var steps: [[Bool]] // 2D array of booleans that determine to play the given track number (based on array index) if true
    var numberOfBars = 4
    var timeSignature = 4 // number of beats in a bar
    var maxNumberOfTracks = 16

    init() {
        steps = [[Bool]](repeating: [Bool](repeating: false, count: numberOfBars * timeSignature), count: maxNumberOfTracks)
    }
    
    func toggleStep(track: Int, beat: Int){
        if track >= 0 && track < steps.count{
            if beat >= 0 && beat < steps[track].count {
                steps[track][beat] = !steps[track][beat]
            }
        }
    }
}

class StepSequencerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_createStepSequencer() {
        let stepSequencer = StepSequencer()
        let numberOfTracks = 16
        let numberOfBars = 4
        let timeSignature = 4
        
        XCTAssertEqual(stepSequencer.maxNumberOfTracks, numberOfTracks)
        XCTAssertEqual(stepSequencer.numberOfBars, numberOfBars)
        XCTAssertEqual(stepSequencer.timeSignature, timeSignature)
        for step in stepSequencer.steps {
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
