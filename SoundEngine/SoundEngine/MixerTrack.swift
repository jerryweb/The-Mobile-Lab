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
    var soloActive: Bool
    
    init(name: String){
        self.name = name
        soloActive = false
        muted = false
        audioMixerNode = AVAudioMixerNode()
        audioMixerNode.outputVolume = 0.75       // the output volume of the mixer
        audioMixerNode.volume = 1.0             // bus' input volume of the mixer
        audioMixerNode.pan = 0.0
    }

    // the volume threshhold is between 0 and 1 inclusive
    func changeVolume(_ vol: Float){
        var tempVol = vol
        tempVol = min(tempVol, 1.0)
        tempVol = max(tempVol, 0.0)
        audioMixerNode.outputVolume = tempVol
    }
    
    // the pan threshhold is between -1 and 1 inclusive
    func changePan(_ pan: Float) {
        var tempPan = pan
        tempPan = min(tempPan, 1.0)
        tempPan = max(tempPan, -1.0)
        audioMixerNode.pan = tempPan
    }
    
    // mut the output volume of the mixer
    func mute() {
        muted = !muted
        
        if muted {
            audioMixerNode.volume = 0.0
        } else {
            audioMixerNode.volume = 1.0
        }
    }
    
    func solo(){
        soloActive = !soloActive
        if muted {
            mute()
        }
    }
}
