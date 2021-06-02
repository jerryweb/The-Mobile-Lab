//
//  SoundGeneratorModel.swift
//  Mobile Lab - UIKit
//
//  Created by Jerry on 6/2/21.
//  This class contains data on the sound generators such as samplers and audio units for virtual instruments

import Foundation
import AVFoundation


class SoundGeneratorModel : AVAudioPlayerNode {
    
    var name: String
    var audioFile: AVAudioFile?
    
    init(generatorName: String?) {
        
        if let name = generatorName {
            self.name = name
        } else {
            self.name = "Sample"
        }
        
        // default pan = 0.0 and volume = 1.0
        super.init()
                
    }
    
    private func loadSample(filePath: String?, fileExtension: String?) {
        
        guard let fileURL = Bundle.main.url(forResource: filePath, withExtension: fileExtension)
        else {
            print("Failed to load sample file \(filePath)")
            return
        }
        
        
        
        
        
    }
  
}
