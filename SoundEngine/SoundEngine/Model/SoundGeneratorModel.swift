//
//  SoundGeneratorModel.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
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

    func loadSample(filePath: String?, fileExtension: String?) {
            
        do {
            guard let filePath = filePath, let fileExtension = fileExtension else {
                print("The file name and/or extension are missing")
                return
            }
            
            let manager = FileManager.default
            guard var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Failed to load sample file \(String(describing: filePath))")
                return
            }
            
            url.appendPathComponent(filePath)
            url.appendPathExtension(fileExtension)
            audioFile = try AVAudioFile(forReading: url)
            
        } catch {
            print("Unable to read audio file \(error.localizedDescription)")
        }
        
    }
}
