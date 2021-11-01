//
//  AudioPlayerNodeSpy.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/28/21.
//

import Foundation
import AVFoundation
@testable import SoundEngine

class AudioPlayerNodeSpy : AVAudioPlayerNode, PlayerNode {
    
    var playCount = 0
    var fileScheduled = false
    
    override func play() {
        playCount += 1
        fileScheduled = false
    }
    
    func scheduleBuffer(_ buffer: AVAudioPCMBuffer, at when: AVAudioTime?, completionHandler: AVAudioNodeCompletionHandler? = nil) {
        fileScheduled = true
        completionHandler!()
    }
}
