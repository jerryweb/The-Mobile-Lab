//
//  SoundGeneratorController.swift
//  SoundEngine
//
//  Created by Jerry on 8/29/21.
//

import Foundation
import AVFoundation

class SoundGeneratorController {
    
    private var soundGeneratorModel : SoundGeneratorModel?
    
    init(_ soundGenerator: SoundGeneratorModel) {
        
        soundGeneratorModel = soundGenerator
    }
    
    init (){
        
    }
    func setSoundGenerator(_ soundGenerator: SoundGeneratorModel) {
        soundGeneratorModel = soundGenerator
    }
    
    func getSoundGenerator() -> SoundGeneratorModel? {
        return soundGeneratorModel
    }
    
    func setVolume(_ vol: Float) {
        
        guard let soundGenerator = soundGeneratorModel else {
            print("Sound Generator not initialized for Sound Generator Controller \(self)")
            return
        }
        
        soundGenerator.volume = max(0.0, vol)
        soundGenerator.volume = min(1.0, vol)
        return
    }
    
    func setPan(_ pan: Float) {
        
        guard let soundGenerator = soundGeneratorModel else {
            print("Sound Generator not initialized for Sound Generator Controller \(self)")
            return
        }
        
        soundGenerator.pan = max(-1.0, pan)
        soundGenerator.pan = min(1.0, pan)
        return
    }
    
    func loadSoundSource(_ soundSource: SoundSourceModel) {
        guard let soundGenerator = soundGeneratorModel else {
            print("Sound Generator not initialized for Sound Generator Controller \(self)")
            return
        }
        
        soundGenerator.soundSource = soundSource
    }
    
    func getSoundSource() -> SoundSourceModel? {
        return soundGeneratorModel?.soundSource
    }
    
}
