//
//  SoundEngineManager.swift
//  MobileLab
//
//  Created by Jerry on 12/13/21.
//

import Foundation
import SoundEngine

class SoundEngineManager {
    
    var engine: PlaybackEngine
    var mixerTrackModels: [MixerTrackModel]
    init(){
        engine = PlaybackEngine()
        mixerTrackModels = [MixerTrackModel]()
        for index in 0...engine.getChannelCount() {
            let mixerTrackModel = MixerTrackModel(id: UUID(),
                                                  trackName: engine.getChannelName(index) ?? "track \(index)",
                                                  volume: engine.getChannelOutputVolume(index),
                                                  pan: engine.getChannelPan(index),
                                                  muted: engine.isChannelMuted(channel: index))
            mixerTrackModels.append(mixerTrackModel)
        }
        
        
    }
    
    
}
