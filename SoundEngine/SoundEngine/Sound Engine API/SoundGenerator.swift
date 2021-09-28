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

class SoundGenerator {
    
    // MARK: Properties
    var name: String
    private var soundSource: SoundSource?
    var audioPlayerNode: AVAudioPlayerNode
    
    init(generatorName: String?) {

        if let name = generatorName {
            self.name = name
        } else {
            self.name = "Sample"
        }
        
        audioPlayerNode = AVAudioPlayerNode()
        
    }
    
    func setVolume(_ vol: Float) {
        
        audioPlayerNode.volume = max(0.0, vol)
        audioPlayerNode.volume = min(1.0, vol)
        return
    }
    
    func setPan(_ pan: Float) {
        audioPlayerNode.pan = max(-1.0, pan)
        audioPlayerNode.pan = min(1.0, pan)
        return
    }
    
    func loadSoundSource(_ soundSource: SoundSource) {
        self.soundSource = soundSource
    }
    
    func getSoundSource() -> SoundSource? {
        return soundSource
    }
}
