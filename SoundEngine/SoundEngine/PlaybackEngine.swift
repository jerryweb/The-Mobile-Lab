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
    var mixerTracks: [Track]
    var soundGenerators: [SoundGenerator]
    var stepSequencer: StepSequencer
    
    init(){
        audioEngine = AVAudioEngine()
        mixerTracks = [Track]()
        soundGenerators = [SoundGenerator]()
        stepSequencer = StepSequencer()
    }
    
//    func createMixerTrack(){
//        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
//        mixerTracks.append(mixerTrack)
//        audioEngine.attach(mixerTrack.audioMixerNode)
//        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
//    }
    
    func createChannel(playerNode: PlayerNode){
        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
        let samplePlayer = SamplePlayer(name: "Sample \(String(self.soundGenerators.count))", playerNode: playerNode)
        
        mixerTracks.append(mixerTrack)
        audioEngine.attach(mixerTrack.audioMixerNode)
        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
        
        soundGenerators.append(samplePlayer)
        audioEngine.attach(samplePlayer.audioPlayerNode)
        audioEngine.connect(samplePlayer.audioPlayerNode, to: mixerTrack.audioMixerNode, format: samplePlayer.audioPlayerNode.outputFormat(forBus: 0))
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
    
    func loadAudioFile(channel: Int, audioFile: AVAudioFile){
        if !soundGenerators.isEmpty && channel < soundGenerators.count {
            soundGenerators[channel].setAudioFile(file: audioFile)
        }
    }
    
    func playChannel(channel: Int) {
        if !soundGenerators.isEmpty && channel < soundGenerators.count {
            soundGenerators[channel].play()
        }
    }
    
    func muteChannel(channel: Int) {
        if !mixerTracks.isEmpty && channel < mixerTracks.count {
            mixerTracks[channel].mute()
        }
    }
    
    func soloChannel(channel: Int) {
        if !mixerTracks.isEmpty && channel < mixerTracks.count {
            mixerTracks[channel].solo()
            print(mixerTracks[channel].soloActive)
            let shouldMute = mixerTracks[channel].soloActive
            for num in 0..<mixerTracks.count {
                if num != channel {
                    mixerTracks[num].muted = shouldMute
                }
            }
        }
    }
    
    func toggleSequenceStep(track: Int, beat: Int){
        stepSequencer.toggleStep(track: track, beat: beat)
    }
}
