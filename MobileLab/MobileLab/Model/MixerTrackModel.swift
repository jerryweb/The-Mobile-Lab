//
//  MixerTrackModel.swift
//  MobileLab
//
//  Created by Jerry on 12/13/21.
//

import Foundation

struct MixerTrackModel{
    var id: UUID
    var trackName: String
    var volume: Float
    var pan: Float
    var muted: Bool
}
