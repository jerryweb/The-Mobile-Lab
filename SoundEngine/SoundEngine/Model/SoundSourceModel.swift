//
//  SoundSourceModel.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import Foundation
import AVFoundation


class SoundSourceModel {
    
    var name: String
    var audioFile: AVAudioFile?
    
    init(sourceName: String?) {

        if let name = sourceName {
            self.name = name
        } else {
            self.name = "Sample"
        }
    }
    
}
