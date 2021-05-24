//
//  MixerTrackModel.swift
//  The Mobile Lab with UIKit
//
//  Created by Jerry on 5/23/21.
//  This class holds the information for each indiviual track such as volume, pan and wether the track is muted

import Foundation
import AVFoundation

class MixerTrackModel {
    private var volume: Float
    private var pan: Float
    private var trackName: String
    private var mute: Bool
    
    init(_ trackName: String?) {
        
        if let name = trackName {
            self.trackName = name
        } else {
            self.trackName = "Track 1"
        }
        
        self.volume = 0.5
        self.pan = 0
        self.mute = false
    }
    
    func getName() -> String {
        return trackName
    }
    
    func getVolume() -> Float{
        return volume
    }
    
    func getPan() -> Float {
        return pan
    }
    
    func isMuted() -> Bool {
        return mute
    }
    
}
