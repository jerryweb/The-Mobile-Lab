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
//        playSemaphore.wait()
//        playSequence()
        
    }
    
    
//    func createMixerTrack(){
//        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
//        mixerTracks.append(mixerTrack)
//        audioEngine.attach(mixerTrack.audioMixerNode)
//        audioEngine.connect(mixerTrack.audioMixerNode, to: audioEngine.mainMixerNode, format: mixerTrack.audioMixerNode.outputFormat(forBus: 0))
//    }
    
    public func createTrack(){
        let mixerTrack = MixerTrack(name: "Track \(String(self.mixerTracks.count))")
        let samplePlayer = SamplePlayer(name: "Sample \(String(self.soundGenerators.count))")
        
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
            if channel >= 0 && channel < mixerTracks.count {
                let mixerNode = mixerTracks[channel].audioMixerNode
                let soundGeneratorNode = (soundGenerators[channel] as! SamplePlayer).audioPlayerNode
                
                print("Mixer node input format before change: \(mixerNode.inputFormat(forBus: 0))")
                print("Sound generator node output format before change: \(soundGeneratorNode.outputFormat(forBus: 0))")
                soundGenerators[channel].setAudioFile(file: audioFile)
                
                audioEngine.detach(soundGeneratorNode)
                audioEngine.disconnectNodeInput(mixerNode)
                
                audioEngine.attach(soundGeneratorNode)
                audioEngine.connect(soundGeneratorNode, to: mixerNode, format: (soundGenerators[channel] as! SamplePlayer).audioFormat)
                
                print("Mixer node input format after change: \(mixerNode.inputFormat(forBus: 0))")
                print("Sound generator node output format after change: \(soundGeneratorNode.outputFormat(forBus: 0))")
            }
        }
    }
     
    public func getMasterVolume() -> Float {
        return audioEngine.mainMixerNode.outputVolume
    }
    
    public func changeMasterVolume(_ vol: Float){
        var tempVol = vol
        tempVol = min(tempVol, 1.0)
        tempVol = max(tempVol, 0.0)
        audioEngine.mainMixerNode.outputVolume = tempVol
    }
    //MARK: Channel specific functions
    public func getChannelCount() -> Int {
        return mixerTracks.count
    }
    
    public func getChannelName(_ channel: Int) -> String? {
        if channel >= 0 && channel < mixerTracks.count {
            return mixerTracks[channel].name
        }
        return nil
    }
    public func getChannelOutputVolume(_ channel: Int) -> Float{
        if channel >= 0 && channel < mixerTracks.count {
            return mixerTracks[channel].audioMixerNode.outputVolume
        }
        return 0
    }
    
    public func setChannelOutputVolume(channel: Int, vol: Float) {
        if channel >= 0 && channel < mixerTracks.count {
            mixerTracks[channel].changeVolume(vol)
        }
    }
    
    public func getChannelPan(_ channel: Int) -> Float{
        if channel >= 0 && channel < mixerTracks.count {
            return mixerTracks[channel].audioMixerNode.pan
        }
        return 0
    }
    
    public func setChannelPan(channel: Int, pan: Float) {
        if channel >= 0 && channel < mixerTracks.count {
            mixerTracks[channel].changePan(pan)
        }
    }
    
    public func playChannel(channel: Int) {
        if channel >= 0 && channel < soundGenerators.count {
            soundGenerators[channel].play()
        }
    }
    
    public func muteChannel(channel: Int) {
        if channel >= 0 && channel < mixerTracks.count {
            mixerTracks[channel].mute()
        }
    }
    
    public func isChannelMuted(_ channel: Int) -> Bool {
        if channel >= 0 && channel < mixerTracks.count {
            return mixerTracks[channel].muted
        }
        return false
    }
    
    public func soloChannel(channel: Int) {
        if channel >= 0 && channel < mixerTracks.count {
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
