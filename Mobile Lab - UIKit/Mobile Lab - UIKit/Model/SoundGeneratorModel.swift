//
//  SoundGeneratorModel.swift
//  Mobile Lab - UIKit
//
//  Created by Jerry on 6/2/21.
//

import Foundation
import AVFoundation


class SoundGeneratorModel : AVAudioPlayerNode {
    
    var name: String
    
    init(generatorName: String?) {
        
        if let name = generatorName {
            self.name = name
        } else {
            self.name = "Sample"
        }
        
    }
  
}
