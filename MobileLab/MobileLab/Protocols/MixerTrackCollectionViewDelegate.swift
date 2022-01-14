//
//  MixerTrackCollectionViewDelegate.swift
//  MobileLab
//
//  Created by Jerry on 1/6/22.
//

import Foundation
import UIKit

protocol MixerTrackCollectionViewDelegate: UIViewController {
    func tapChannelMuteButton(trackIndex: Int)
    func changeChannelVolume(trackIndex: Int, vol: Float)
    func changeChannelPan(trackIndex: Int, pan: Float)
}
