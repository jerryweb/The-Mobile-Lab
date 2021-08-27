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
    private var audioSampleRate: Double = 0
    
    init(sampleFile: AVAudioFile) {
        name = sampleFile.description
        setAudioSample(sampleFile)
    }
    init(sourceName: String) {
        name = sourceName
    }
    init() {
        name = "Sample"
    }
    
    func setAudioSample(_ audioFile: AVAudioFile) {
        self.audioFile = audioFile
        let format = audioFile.fileFormat
        
        audioSampleRate = format.sampleRate
    }
    
//    func loadSampleFile(filePath: String?, fileExtension: String?) {
//
//        do {
//            guard let filePath = filePath, let fileExtension = fileExtension else {
//                print("The file name and/or extension are missing")
//                return
//            }
//
//            let manager = FileManager.default
//            guard var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//                print("Failed to load sample file \(String(describing: filePath))")
//                return
//            }
//
//            url.appendPathComponent(filePath)
//            url.appendPathExtension(fileExtension)
//            let file = try AVAudioFile(forReading: url)
//            let format = file.processingFormat
//            audioFile = file
//            audioSampleRate = format.sampleRate
//
//        } catch {
//            print("Unable to read audio file \(error.localizedDescription)")
//        }
//    }
}
