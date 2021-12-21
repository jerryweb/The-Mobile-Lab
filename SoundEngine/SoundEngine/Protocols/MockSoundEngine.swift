//
//  MockSoundEngine.swift
//  SoundEngine
//
//  Created by Jerry on 12/21/21.
//

import Foundation

public protocol MockSoundEngine {
    func play()
    var isPlaying: Bool { get set }
}
