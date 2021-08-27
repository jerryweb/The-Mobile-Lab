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

    
    func setVolume(_ vol: Float) {
        volume = max(0.0, vol)
        volume = min(1.0, vol)
        return
    }
    
    func setPan(_ pan: Float) {
        self.pan = max(-1.0, pan)
        self.pan = min(1.0, pan)
        return
    }
    
    func loadSoundSource(_ soundSource: SoundSourceModel = SoundSourceModel()) {
        self.soundSource = soundSource
    }
}
