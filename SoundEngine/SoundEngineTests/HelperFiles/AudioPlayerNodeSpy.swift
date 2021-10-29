//
//  AudioPlayerNodeSpy.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/28/21.
//

import Foundation
import AVFoundation

class AudioPlayerNodeSpy : AVAudioPlayerNode, AudioPlayerNode {
    
    var playCount = 0
    var fileScheduled = false
    
    override func play() {
        playCount += 1
        fileScheduled = false
    }
    
    func scheduleAudioBuffer() {
        fileScheduled = true
    }
}
