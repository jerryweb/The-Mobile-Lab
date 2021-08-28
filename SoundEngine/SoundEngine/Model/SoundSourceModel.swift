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
        name = sampleFile.url.lastPathComponent
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
        name = audioFile.url.lastPathComponent
        let format = audioFile.fileFormat
        audioSampleRate = format.sampleRate
    }
}
