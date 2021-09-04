//
//  PlayBackEngine.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import Foundation
import AVFoundation

class PlayBackEngine : AVAudioEngine {
    
    override init() {
        super.init()
    }
    
    func attachNodes(soundGenerators: [AVAudioPlayerNode], mixerTracks: [AVAudioMixerNode]) {
        for soundGenerator in soundGenerators {
            self.attach(soundGenerator)
        }
        
        
    }
    
}
