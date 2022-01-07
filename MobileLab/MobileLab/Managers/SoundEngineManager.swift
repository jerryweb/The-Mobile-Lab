//
//  SoundEngineManager.swift
//  MobileLab
//
//  Created by Jerry on 12/13/21.
//

import Foundation
import SoundEngine
import AVFoundation

class SoundEngineManager {
    
    var engine: PlaybackEngine
    var mixerTrackModels: [MixerTrackModel]
    
    init(){
        engine = PlaybackEngine()
        mixerTrackModels = [MixerTrackModel]()
    }
    
    func createTracks(count: Int){
        for index in 0..<count {
            engine.createTrack()
            print("Created channel \(index)")
        }
        
        for index in 0..<engine.getChannelCount() {
                    let mixerTrackModel = MixerTrackModel(id: UUID(),
                                                          trackName: engine.getChannelName(index) ?? "track \(index)",
                                                          volume: engine.getChannelOutputVolume(index),
                                                          pan: engine.getChannelPan(index),
                                                          muted: engine.isChannelMuted(index),
                                                          trackNumber: index)
                    mixerTrackModels.append(mixerTrackModel)
        }
    }
    

    
    func playChannel(_ channelIndex: Int){
        engine.playChannel(channel: channelIndex)
    }
    
    func muteChannel(_ channelIndex: Int){
        engine.muteChannel(channel: channelIndex)
    }
    
    func isChannelMuted(_ channelIndex: Int) -> Bool{
        return engine.isChannelMuted(channelIndex)
    }
    
    func getMasterVolume() -> Float {
        return engine.getMasterVolume()
    }
    
    func setMasterVolume(_ vol: Float) {
        engine.changeMasterVolume(vol)
    }
    
    func getChannelVolume(_ channel: Int) -> Float {
        return engine.getChannelOutputVolume(channel)
    }
    
    func getChannelPan(_ channel: Int) -> Float  {
        return engine.getChannelPan(channel)
    }
    
    func setChannelVolume(_ channel: Int, _ vol: Float){
        engine.setChannelOutputVolume(channel: channel, vol: vol)
    }
    
    func setChannelPan(_ channel: Int, _ pan: Float){
        engine.setChannelPan(channel: channel, pan: pan)
    }
    
    func getChannelName(_ channel: Int) -> String {
        return engine.getChannelName(channel) ?? "No Sample"
    }
    
    func soloChannel(_ channel: Int) {
        return engine.soloChannel(channel: channel)
    }
    
    func playSequence(){
        engine.startSequence()
    }
    
    func stopSequence(){
        engine.stopSequence()
    }
    
    func loadSample(channel: Int, sampleFile: AVAudioFile){
        engine.loadAudioFile(channel: channel, audioFile: sampleFile)
        if channel >= 0 && channel < mixerTrackModels.count {
            mixerTrackModels[channel].trackName = sampleFile.url.lastPathComponent
        }
    }
    
    func loadTestSounds(){
        let filePaths = ["Heavy Kick", "LEX Clap(3)", "LEX Rim(2)", "Hi_Tom2", "Hi_Shk3", "DT - Sound15", "CB_Hat", "Cap_Snr"]
        let fileExtension = "wav"
        
        let testBundle = Bundle(for: type(of: self))
        
        for pathIndex in 0..<filePaths.count {
            guard let url = testBundle.url(forResource: filePaths[pathIndex], withExtension: fileExtension)
            else {
                print("Unable to load audio file: \(filePaths[pathIndex])")
                return
            }
            
            do {
                let file = try AVAudioFile(forReading: url)
                loadSample(channel: pathIndex, sampleFile: file)
            }
            catch {
                print("Unable to read audio file \(error.localizedDescription)")
            }
        }
       
        
    }
}
