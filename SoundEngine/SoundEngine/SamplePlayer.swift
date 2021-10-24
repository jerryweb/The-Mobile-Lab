//
//  SamplePlayer.swift
//  SoundEngine
//
//  Created by Jerry on 10/23/21.
//

import Foundation
import AVFoundation

class SamplePlayer : SoundGenerator {
    var name: String
    var sampleFile: AVAudioFile?
    var audioPlayerNode: AVAudioPlayerNode
    var audioSampleRate: Double = 0
    
    init(name: String){
        self.name = name
        self.audioPlayerNode = AVAudioPlayerNode()
    }
    
    func play(){
        if let _ = sampleFile {
            audioPlayerNode.play()
        }
    }
    
    func setAudioFile(file: AVAudioFile){
        sampleFile = file
        audioSampleRate = file.fileFormat.sampleRate
    }
}
