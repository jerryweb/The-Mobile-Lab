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
    }

    
}
