//
//  AudioViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/13/22.
//
//  This contains the protocol and extension used for every view controller that interacts and changes audio plaback. This protocol should house functions used to create and maintain the central audio framework instance.

import Foundation
import UIKit

protocol AudioViewController {
    func setSoundEngineManager(soundEngineManager: SoundEngineManager)
    func setChildUIViewController(childViewController: UIViewController)
}

