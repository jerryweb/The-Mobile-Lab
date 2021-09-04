//
//  SoundGeneratorModel.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//
// default values: pan = 0.0 and volume = 1.0

import Foundation
import AVFoundation


// MARK: Sound Generator Module

class SoundGeneratorModel {

    var name: String
    var soundSource: SoundSourceModel?
    var audioPlayerNode: AVAudioPlayerNode
    
    init(generatorName: String?) {

        if let name = generatorName {
            self.name = name
        } else {
            self.name = "Sample"
        }
        
        audioPlayerNode = AVAudioPlayerNode()
    }
}
