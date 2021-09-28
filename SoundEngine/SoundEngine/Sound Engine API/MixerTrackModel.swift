//
//  MixerTrackModel.swift
//  SoundEngine
//
//  Created by Jerry on 9/3/21.
//

import Foundation
import AVFoundation

class MixerTrackModel {
    
    // MARK: Properties
    var name: String
    var audioMixerNode: AVAudioMixerNode
    var soundGenerator: SoundGenerator?
    
    
    // MARK: Constructors
    init() {
        name = "track 1"
        audioMixerNode = AVAudioMixerNode()
    }
    
    init(name: String) {
        self.name = name
        audioMixerNode = AVAudioMixerNode()
    }
    
    init(soundGenerator: SoundGenerator) {
        self.soundGenerator = soundGenerator
        self.name = soundGenerator.name
        audioMixerNode = AVAudioMixerNode()
    }
}
