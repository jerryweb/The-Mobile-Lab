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
    
    init(name: String){
        self.name = name
        self.audioPlayerNode = AVAudioPlayerNode()
    }
    
    func play(){
        audioPlayerNode.play()
    }
}
