//
//  PlaybackEngine.swift
//  SoundEngine
//
//  Created by Jerry on 10/20/21.
//

import Foundation
import AVFoundation

class PlaybackEngine {
    var audioEngine: AVAudioEngine
    var mixerTracks: [MixerTrack]
    
    init(){
        audioEngine = AVAudioEngine()
        mixerTracks = [MixerTrack]()
    }
    
    func createMixerTrack(){
        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
        mixerTracks.append(mixerTrack)
        audioEngine.attach(mixerTrack.audioMixerNode)
        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
    }
    
    func deleteMixerTrack(trackNumber: Int){
        if trackNumber >= 0 && trackNumber < mixerTracks.count {
            audioEngine.detach(mixerTracks[trackNumber].audioMixerNode)
            mixerTracks.remove(at: trackNumber)
        }
    }
    
    func startEngine() {
        audioEngine.prepare()
        do {
          try audioEngine.start()
        } catch  {
          print("Error starting playback engine: \(error.localizedDescription)")
        }
    }
    
    func stopEngine(){
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
}