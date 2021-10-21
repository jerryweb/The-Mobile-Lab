//
//  MixerTrack.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/20/21.
//

import Foundation
import AVFoundation

class MixerTrack {
    
    var name: String
    var audioMixerNode: AVAudioMixerNode
    
    init(name: String){
        self.name = name
        audioMixerNode = AVAudioMixerNode()
    }
    
    deinit {
        print("Mixer track \(name) has been deinitialized.")
    }
}
