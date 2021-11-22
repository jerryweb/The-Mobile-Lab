//
//  PlaybackEngine.swift
//  SoundEngine
//
//  Created by Jerry on 10/20/21.
//

import Foundation
import AVFoundation

public class PlaybackEngine {
    var audioEngine: AVAudioEngine
    var mixerTracks: [Track]
    var soundGenerators: [SoundGenerator]
    var stepSequencer: StepSequencer
    var isPlaying: Bool
    
    let playSemaphore = DispatchSemaphore(value: 1)
    let playSequenceDispatchQueue = DispatchQueue.global()
    
    public init(){
        audioEngine = AVAudioEngine()
        mixerTracks = [Track]()
        soundGenerators = [SoundGenerator]()
        stepSequencer = StepSequencer()
        isPlaying = false
        playSemaphore.wait()
        playSequence()
        
    }
    
//    func createMixerTrack(){
//        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
//        mixerTracks.append(mixerTrack)
//        audioEngine.attach(mixerTrack.audioMixerNode)
//        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
//    }
    
//    public func createChannel(playerNode: PlayerNode){
    public func createChannel(playerNode: AVAudioPlayerNode){
        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
        let samplePlayer = SamplePlayer(name: "Sample \(String(self.soundGenerators.count))", playerNode: playerNode)
        
        mixerTracks.append(mixerTrack)
        audioEngine.attach(mixerTrack.audioMixerNode)
        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
        
        soundGenerators.append(samplePlayer)
        audioEngine.attach(samplePlayer.audioPlayerNode)
        audioEngine.connect(samplePlayer.audioPlayerNode, to: mixerTrack.audioMixerNode, format: samplePlayer.audioPlayerNode.outputFormat(forBus: 0))
    }

    public func startEngine() {
        audioEngine.prepare()
        do {
          try audioEngine.start()
        } catch  {
          print("Error starting playback engine: \(error.localizedDescription)")
        }
    }
    
    public func stopEngine(){
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
    
    public func loadAudioFile(channel: Int, audioFile: AVAudioFile){
        if !soundGenerators.isEmpty && channel < soundGenerators.count {
            soundGenerators[channel].setAudioFile(file: audioFile)
        }
    }
    
    public func playChannel(channel: Int) {
        if !soundGenerators.isEmpty && channel < soundGenerators.count {
            soundGenerators[channel].play()
        }
    }
    
    public func muteChannel(channel: Int) {
        if !mixerTracks.isEmpty && channel < mixerTracks.count {
            mixerTracks[channel].mute()
        }
    }
    
    public func soloChannel(channel: Int) {
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
    
    func startSequence(){
        if !isPlaying {
            isPlaying = true
            playSemaphore.signal()
        }
    }
    
    func stopSequence(){
        if isPlaying {
            isPlaying = false
            playSemaphore.wait()
        }
    }
    
    func playSequence(){
        playSequenceDispatchQueue.async {
            var step = 0
            while step < self.stepSequencer.steps[0].count {
                self.playSemaphore.wait()
                for track in self.stepSequencer.steps {
                    if track[step] {
                        print("playing step \(step) for track \(track)")
                    }
                }
                self.playSemaphore.signal()
                if step == self.stepSequencer.steps[0].count - 1 {
                    step = 0
                }
            }
        }
    }
}
