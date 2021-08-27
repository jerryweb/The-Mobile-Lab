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
    
    init(sourceName: String) {
        name = sourceName
    }
    init() {
        name = "Sample"
    }
    
    
    func loadSampleFile(filePath: String?, fileExtension: String?) {
            
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
