//
//  MixerTrackModel.swift
//  The Mobile Lab with UIKit
//
//  Created by Jerry on 5/23/21.
//  This class holds the information for each indiviual track such as volume, pan and wether the track is muted

import Foundation
import AVFoundation

class MixerTrackModel {
    var volume: Float
    var pan: Float
    var trackName: String
    var mute: Bool
    
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
    
    func setVolume(_ volume: Float) -> Void{
        
        if volume < Volume.minVolume {
            self.volume = Volume.minVolume
        }
        else if volume > Volume.maxVolume {
            self.volume = Volume.maxVolume
        }
        else {
            self.volume = volume
        }
        
        return
    }
    
    func setPan(_ pan: Float) -> Void{
        
        if pan < Pan.letfPanLimit {
            self.pan = Pan.letfPanLimit
        }
        else if pan > Pan.rightPanLimit {
            self.pan = Pan.rightPanLimit
        }
        else {
            self.pan = pan
        }
        
        return
    }
    
    
    func toggleMute() -> Void {
        mute = !mute
    }
    
}
