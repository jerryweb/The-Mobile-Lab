//
//  PlayBackEngine.swift
//  SoundEngine
//
//  Created by Jerry on 8/26/21.
//

import Foundation
import AVFoundation

class PlayBackEngine {
    
    // MARK: Properties
    var audioEngine: AVAudioEngine
    var mixerTracks: [MixerTrackModel]
    var soundGenerators: [SoundGeneratorModel]
    
    init() {
        audioEngine = AVAudioEngine()
        mixerTracks = [MixerTrackModel]()
        soundGenerators = [SoundGeneratorModel]()
    }
    
    
    func createMixerTrack(){
        let mixerTrack = MixerTrackModel()
        mixerTracks.append(mixerTrack)
        attachAudioNode(node: mixerTrack.audioMixerNode)
    }
    
    func createMixerTrack(name: String){
        let mixerTrack = MixerTrackModel(name: name)
        mixerTracks.append(mixerTrack)
        attachAudioNode(node: mixerTrack.audioMixerNode)
    }
    
    func createMixerTrack(soundGenerator: SoundGeneratorModel){
        let mixerTrack = MixerTrackModel(soundGenerator: soundGenerator)
        mixerTracks.append(mixerTrack)
        attachAudioNode(node: mixerTrack.audioMixerNode)
    }
    
    func attachAudioNode(node: AVAudioNode){
        audioEngine.attach(node)
    }
}
