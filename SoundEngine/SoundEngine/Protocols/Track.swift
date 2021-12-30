//
//  Track.swift
//  SoundEngine
//
//  Created by Jerry on 10/23/21.
//

import Foundation
import AVFoundation

protocol Track  {
    var audioMixerNode: AVAudioMixerNode { get set }
    var name: String { get set }
    var muted: Bool { get set }
    var soloActive: Bool { get set }
    func mute()
    func solo()
    func changePan(_ pan: Float)
    func changeVolume(_ vol: Float)
}
