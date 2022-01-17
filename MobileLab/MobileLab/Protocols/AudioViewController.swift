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
    var soundEngineManager : SoundEngineManager { get set }
}

extension AudioViewController {
    func setMasterVolume(vol: Float, masterVolumeFader: UISlider, masterVolumePercentageLabel: UILabel){
        print("Master Volume = \(masterVolumeFader.value)")
        soundEngineManager.setMasterVolume(vol)
        masterVolumePercentageLabel.text = "\(Int(masterVolumeFader.value * 100))%"
    }
    
    func updateMasterVolumeViews(masterVolumeFader: UISlider, masterVolumePercentageLabel: UILabel){
        masterVolumeFader.setValue(soundEngineManager.getMasterVolume(), animated: false)
        masterVolumePercentageLabel.text = "\(Int(masterVolumeFader.value * 100))%"
    }
    
    func setChildUIViewController(childViewController: UIViewController) {
        return
    }
}
