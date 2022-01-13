//
//  PlaybackEngine.swift
//  SoundEngine
//
//  Created by Jerry on 10/20/21.
//

import Foundation
import AVFoundation

public protocol soundEngineProtocol {
    func playSequence()
    func startSequence()
    func stopSequence()
    func playChannel(channel: Int)
    func createTrack()
    func startEngine()
    func stopEngine()
    func loadAudioFile(channel: Int, audioFile: AVAudioFile)
    func getMasterVolume() -> Float
    func changeMasterVolume(_ vol: Float)
    func getChannelCount() -> Int
    func getChannelName(_ channel: Int) -> String?
    func getChannelOutputVolume(_ channel: Int) -> Float
    func setChannelOutputVolume(channel: Int, vol: Float)
    func getChannelPan(_ channel: Int) -> Float
    func setChannelPan(channel: Int, pan: Float)
}

public class PlaybackEngine : soundEngineProtocol {

    
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
        audioEngine.mainMixerNode.outputVolume = 0.75
    }

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
            let shouldMute = mixerTracks[channel].soloActive
//            print(mixerTracks[channel].soloActive)
            
            for num in 0..<mixerTracks.count {
                if num != channel {
                    mixerTracks[num].muted = shouldMute
                }
            }
        }
    }
    
    public func toggleSequenceStep(track: Int, beat: Int){
        stepSequencer.toggleStep(track: track, beat: beat)
    }
    
    public func playSequence(){
        print("Stating playback sequence")
        var step = 0
        _ = Timer.scheduledTimer(withTimeInterval: 1,
                                 repeats: true,
                                 block: { [weak self] timer in
                                    guard var steps = self?.stepSequencer.steps, var isPlaying = self?.isPlaying, let soundGenerators = self?.soundGenerators  else {
                                        print("Failed to load steps for sequencer")
                                        return
                                    }
                                    if !isPlaying {
                                        print("Stopping Audio Playback")
                                        timer.invalidate()
                                    }
                                    for track in 0..<steps.count {
                                        if steps[track][step] {
                                            print("playing step \(step) for track \(track)")
                                            soundGenerators[track].play()
                                        }
                                    }
                                    step += 1
                                    if step == steps[step].count - 1 {
                                        step = 0
                                    }
        })
        
    }
    
    public func startSequence(){
        playSequence()
        if !isPlaying {
            isPlaying = true
        }
    }
    
    public func stopSequence(){
        if isPlaying {
            isPlaying = false
        }
    }
    
    public func getSequenceStep(track: Int, beat: Int) -> Bool {
        return stepSequencer.getStep(track: track, beat: beat)
    }
    
    public func getTotatSteps() -> Int{
        return stepSequencer.steps.count * stepSequencer.steps[0].count
    }
    
}
