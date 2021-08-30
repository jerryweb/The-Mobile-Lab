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

class SoundGeneratorModel : AVAudioPlayerNode {

    var name: String
    var audioFile: AVAudioFile?
    var soundSource: SoundSourceModel?

    
    init(generatorName: String?) {

        if let name = generatorName {
            self.name = name
        } else {
            self.name = "Sample"
        }

        super.init()
    }
}
