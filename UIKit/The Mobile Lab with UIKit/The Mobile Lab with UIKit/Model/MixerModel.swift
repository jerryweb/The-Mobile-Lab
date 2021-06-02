//
//  MixerModel.swift
//  The Mobile Lab with UIKit
//
//  Created by Jerry on 6/1/21.
//  There should only be one mixer instance for the application that will store the AVAudioEngine singleton

import Foundation
import AVFoundation

class MixerModel {
    
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private var audioLengthSamples: AVAudioFramePosition = 0
    private var audioFile: AVAudioFile?
    private var audioSampleRate: Double = 0
    private var audioLengthSeconds: Double = 0
    
    init(){
        
      
      guard let fileURL = Bundle.main.url(forResource: "foolishness ext 2", withExtension: "mp3")
      else {
        return
      }
      
      do {
        let file = try AVAudioFile(forReading: fileURL)
        let fileFormat = file.processingFormat
        
        audioLengthSamples = file.length
        audioSampleRate = fileFormat.sampleRate
        audioLengthSeconds = Double(audioLengthSamples) / audioSampleRate
        
        audioFile = file
        
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: fileFormat)
        engine.prepare()
        
        do {
          try engine.start()
        } catch  {
          print("We just couldn't seem to get the player started:)") //\(error.localizedDescription)")
        }
        
        print(engine.mainMixerNode.volume)
        
        player.scheduleFile(audioFile!, at: nil)
        
        let format = engine.mainMixerNode.outputFormat(forBus: 0)
        
        engine.mainMixerNode.installTap(onBus: 0,
                                        bufferSize: 1024,
                                        format: format) { buffer, _ in
          guard let channelData = buffer.floatChannelData else {
            return
          }
          
          let channelDataValue = channelData.pointee
          
          let channelDataValueArray = stride(from: 0,
                                             to: Int(buffer.frameLength),
                                             by: buffer.stride).map {
                                                  channelDataValue[$0]
                                                }
        
            let rms = sqrt(channelDataValueArray.map {
              return $0 * $0
            }.reduce(0, +) / Float(buffer.frameLength))
            
            let avgPower = 20 * log10(rms)
            
            self.scaledPower(power: avgPower)
            
            
        }
            
        player.play()
        
      } catch {
        print("Can't read the audio file: \(error.localizedDescription)")
      }
    }
    
    private func scaledPower(power: Float) -> Float {
      
      guard power.isFinite else {
        return 0.0
      }
      
      let minDb: Float = -80
      
      if power < minDb {
        return 0.0
      } else if power >= 1.0 {
        return 1.0
      } else  {
        return (abs(minDb) - abs(power)) / abs(minDb)
      }
    }

    
    
}
