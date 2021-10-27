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
    var sampleFile: AudioFile?
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
        self.sampleFile = file as? AudioFile
        self.audioSampleRate = file.fileFormat.sampleRate
        self.audioFormat = file.processingFormat
    }
    
    func setAudioFile(file: AVAudioFile){
        sampleFile = file as? AudioFile
        name = file.url.lastPathComponent
        audioSampleRate = file.fileFormat.sampleRate
        audioFormat = file.processingFormat
    }
    
    func scheduleFile(){
        guard let file = sampleFile, !fileScheduled else {
            print("No audio file loaded for player \(name)!")
          return
        }

        let audioFrameCount = UInt32(file.length)

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
            print(audioBuffer.frameLength)
            self.fileScheduled = true
        }
    }
    
    func play(){
        if let _ = sampleFile {
            if audioPlayerNode.isPlaying {
                audioPlayerNode.stop()
            }
            if !fileScheduled {
                scheduleFile()
            }
            print("play")
            self.audioPlayerNode.play()
            self.fileScheduled = false
        }
    }
}
