//
//  StepSequencer.swift
//  SoundEngine
//
//  Created by Jerry on 11/7/21.
//

import Foundation

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
