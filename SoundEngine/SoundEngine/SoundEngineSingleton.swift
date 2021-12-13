//
//  SoundEngineSingleton.swift
//  SoundEngine
//
//  Created by Jerry on 12/13/21.
//

import Foundation

public class SoundEngineSingleton {
    
    static let shared = SoundEngineSingleton()
    public let playbackEngine: PlaybackEngine
    
    private init(){
        playbackEngine = PlaybackEngine()
    }
    
}
