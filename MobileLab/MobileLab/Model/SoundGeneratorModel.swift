//
//  SoundGeneratorModel.swift
//  MobileLab
//
//  Created by Jerry on 8/25/21.
//

import Foundation
import AVFoundation


// MARK: Sound Generator Module

class SoundGeneratorModel : AVAudioPlayerNode {

    var name: String
    var audioFile: AVAudioFile?

    // default values: pan = 0.0 and volume = 1.0
    init(generatorName: String?) {

        if let name = generatorName {
            self.name = name
        } else {
            self.name = "Sample"
        }

        super.init()
    }

    private func loadSample(filePath: String?, fileExtension: String?) {

        guard let fileURL = Bundle.main.url(forResource: filePath, withExtension: fileExtension)
        else {
            print("Failed to load sample file \(String(describing: filePath))")
            return
        }
    }
}
