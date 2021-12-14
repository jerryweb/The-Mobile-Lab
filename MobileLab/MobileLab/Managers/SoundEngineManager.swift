//
//  SoundEngineManager.swift
//  MobileLab
//
//  Created by Jerry on 12/13/21.
//

import Foundation
import SoundEngine

class SoundEngineManager {
    
    var playbackEngine: PlaybackEngine
    var mixerTrackModels: [MixerTrackModel]
    init(){
        playbackEngine = PlaybackEngine()
        for track in playbackEngine.mixerTracks {
            
        }
    }
    
    
}
