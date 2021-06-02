//
//  TrackAttributeConstants.swift
//  The Mobile Lab with UIKit
//
//  Created by Jerry on 5/23/21.
//  Contains upper and lower limit for the mixer track properties

import Foundation

enum Volume {
    static let maxVolume: Float = 1
    static let minVolume: Float = 0
}

enum Pan {
    static let letfPanLimit: Float = -1
    static let rightPanLimit: Float = 1
}
