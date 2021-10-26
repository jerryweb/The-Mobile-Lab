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
    var audioFormat: AVAudioFormat
    var fileScheduled = false
    
    init(name: String){
        self.name = name
        self.audioPlayerNode = AVAudioPlayerNode()
        self.audioFormat = AVAudioFormat()
    }
    
    init(file: AVAudioFile){
        self.name = file.url.lastPathComponent
        self.audioPlayerNode = AVAudioPlayerNode()
        self.sampleFile = file
        self.audioSampleRate = file.fileFormat.sampleRate
        self.audioFormat = file.processingFormat
    }
    
    func setAudioFile(file: AVAudioFile){
        sampleFile = file
        name = file.url.lastPathComponent
        audioSampleRate = file.fileFormat.sampleRate
        audioFormat = file.processingFormat
//        scheduleFile()
    }
    
    func scheduleFile(){
        guard let file = sampleFile, !fileScheduled else {
            print("No audio file loaded for player \(name)!")
          return
        }
        
        fileScheduled = true
        let audioFrameCount = UInt32(file.length)
        
        guard let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount) else {
            print("Failed to create audio buffer for player \(name)!")
            return
        }
        do{
            try file.read(into: audioBuffer)
            
            audioPlayerNode.scheduleBuffer(audioBuffer, at: nil) {
            }
        }
        catch {
            print("Failed to load file into audio buffer")
        }
//        audioPlayerNode.scheduleFile(file, at: nil) {
//            self.fileScheduled = false
//        }
    }
    
    func play(){
        if let _ = sampleFile {
            if !fileScheduled {
                scheduleFile()
            }
            audioPlayerNode.play()
            fileScheduled = false
        }
    }
}
