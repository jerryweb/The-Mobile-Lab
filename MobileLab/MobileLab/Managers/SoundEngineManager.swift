//
//  SoundEngineManager.swift
//  MobileLab
//
//  Created by Jerry on 12/13/21.
//

import Foundation
import SoundEngine
import AVFoundation

public class SoundEngineManager {
    
    var engine: PlaybackEngine
    var mixerTrackModels: [MixerTrackModel]
    
    public init(){
        engine = PlaybackEngine()
        mixerTrackModels = [MixerTrackModel]()
        
        for index in 0..<16 {
            engine.createChannel()
            print("Created channel \(index)")
        }
        for index in 0..<engine.getChannelCount() {
            let mixerTrackModel = MixerTrackModel(id: UUID(),
                                                  trackName: engine.getChannelName(index) ?? "track \(index)",
                                                  volume: engine.getChannelOutputVolume(index),
                                                  pan: engine.getChannelPan(index),
                                                  muted: engine.isChannelMuted(index))
            mixerTrackModels.append(mixerTrackModel)
        }
        
        let filePath = "Heavy Kick"
        let fileExtension = "wav"
        
        let testBundle = Bundle(for: type(of: self))

        guard let url = testBundle.url(forResource: filePath, withExtension: fileExtension)
        else {
            print("Unable to load audio file: \(filePath)")
            return
        }
        
        do {
            let file = try AVAudioFile(forReading: url)
            loadSample(channel: 0, sampleFile: file)
        }
        catch {
            print("Unable to read audio file \(error.localizedDescription)")
        }
        
        engine.startEngine()
    }
    
    public func playChannel(_ channelIndex: Int){
        engine.playChannel(channel: channelIndex)
    }
    
    public func muteChannel(_ channelIndex: Int){
        engine.muteChannel(channel: channelIndex)
    }
    
    public func isChannelMuted(_ channelIndex: Int) -> Bool{
        return engine.isChannelMuted(channelIndex)
    }
    
    public func getMasterVolume() -> Float {
        return engine.getMasterVolume()
    }
    
    public func setMasterVolume(_ vol: Float) {
        engine.changeMasterVolume(vol)
    }
    
    public func getChannelVolume(_ channel: Int) -> Float {
        return engine.getChannelOutputVolume(channel)
    }
    
    public func getChannelPan(_ channel: Int) -> Float  {
        return engine.getChannelPan(channel)
    }
    
    public func setChannelVolume(_ channel: Int, _ vol: Float){
        engine.setChannelOutputVolume(channel: channel, vol: vol)
    }
    
    public func setChannelPan(_ channel: Int, _ pan: Float){
        engine.setChannelPan(channel: channel, pan: pan)
    }
    
    public func getChannelName(_ channel: Int) -> String {
        return engine.getChannelName(channel) ?? "No Sample"
    }
    
    public func soloChannel(_ channel: Int) {
        return engine.soloChannel(channel: channel)
    }
    
    public func loadSample(channel: Int, sampleFile: AVAudioFile){
        engine.loadAudioFile(channel: channel, audioFile: sampleFile)
    }
}
