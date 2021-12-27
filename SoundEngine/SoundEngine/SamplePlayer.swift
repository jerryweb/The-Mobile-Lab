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
//    var audioPlayerNode: PlayerNode
    var audioPlayerNode: AVAudioPlayerNode
    var audioFormat: AVAudioFormat
    var fileScheduled = false
    
//    init(name: String, playerNode: PlayerNode){
//    init(name: String, playerNode: AVAudioPlayerNode){
//        self.name = name
//        self.audioPlayerNode = playerNode
//        self.audioFormat = AVAudioFormat()
//    }
    
    init(name: String){
        self.name = name
        self.audioPlayerNode = AVAudioPlayerNode()
        self.audioFormat = AVAudioFormat()
    }

    func setAudioFile(file: AVAudioFile){
        sampleFile = file
        name = file.url.lastPathComponent
        audioFormat = file.processingFormat
        scheduleFile()
    }
    
    func scheduleFile(){
        if fileScheduled {
            return
        }
        
        guard let file = sampleFile, !fileScheduled else {
            print("No audio file loaded for player \(name)!")
            return
        }

        let audioFrameCount = UInt32(file.length)
        file.framePosition = 0
        guard let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount) else {
            print("Failed to create audio buffer for player \(name)!")
            return
        }

        do{
            try file.read(into: audioBuffer)
        }
        catch {
            print("Failed to load file into audio buffer")
        }
        
        audioPlayerNode.scheduleBuffer(audioBuffer, at: nil) {
//            print(audioBuffer.frameLength)
            self.fileScheduled = true
            print("Audio file scheduled")
        }
    }
    
    func play(){
        print("play")
//        if let _ = sampleFile {
        if audioPlayerNode.isPlaying {
            audioPlayerNode.stop()
        }
        if !fileScheduled {
            scheduleFile()
        }
        self.audioPlayerNode.play()
        self.fileScheduled = false
        scheduleFile()
//        }
    }
}
