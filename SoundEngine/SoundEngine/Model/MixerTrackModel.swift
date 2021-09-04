//
//  MixerTrackModel.swift
//  SoundEngine
//
//  Created by Jerry on 9/3/21.
//

import Foundation
import AVFoundation

class MixerTrackModel {
    
    var name: String
    var audioMixerNode: AVAudioMixerNode
    var soundGeneratorModel: SoundGeneratorModel?
    
    init() {
        name = "track 1"
        audioMixerNode = AVAudioMixerNode()
    }
    
    init(name: String) {
        self.name = name
        audioMixerNode = AVAudioMixerNode()
    }
}
