//
//  PlayerNode.swift
//  SoundEngine
//
//  Created by Jerry on 10/31/21.
//

import Foundation
import AVFoundation
protocol PlayerNode : AVAudioPlayerNode{
    func play()
    var playCount: Int {get set}
}
