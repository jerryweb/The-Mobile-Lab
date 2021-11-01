//
//  SoundGenerator.swift
//  SoundEngine
//
//  Created by Jerry on 10/23/21.
//

import Foundation
import AVFoundation

protocol SoundGenerator {
    var name: String { get set }
    func play()
    func scheduleFile()
}

protocol AudioFile : AVAudioFile {
    var name: String {get set}
}
