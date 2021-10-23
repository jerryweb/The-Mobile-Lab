//
//  SoundGenerator.swift
//  SoundEngine
//
//  Created by Jerry on 10/23/21.
//

import Foundation

protocol SoundGenerator {
    var name: String { get set }
    func play()
}
