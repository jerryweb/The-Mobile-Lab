//
//  MixerTrack.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/20/21.
//

import Foundation
import AVFoundation

class MixerTrack : Track {
    
    var muted: Bool
    var name: String
    var audioMixerNode: AVAudioMixerNode
    
    init(name: String){
        self.name = name
        self.muted = false
        audioMixerNode = AVAudioMixerNode()
        audioMixerNode.volume = 0.5
        audioMixerNode.pan = 0.0
    }
    
//    deinit {
//        print("Mixer track \(name) has been deinitialized.")
//    }
//
    // the volume threshhold is between 0 and 1 inclusive
    func changeVolume(_ vol: Float){
        audioMixerNode.volume = min(vol, 1.0)
    }
    
    // the pan threshhold is between -1 and 1 inclusive
    func changePan(_ pan: Float) {
        audioMixerNode.pan = min(pan, 1.0)
        audioMixerNode.pan = max(pan, -1.0)
    }
    
    func mute() {
        muted = !muted
    }

    func play() {
        
    }
}
