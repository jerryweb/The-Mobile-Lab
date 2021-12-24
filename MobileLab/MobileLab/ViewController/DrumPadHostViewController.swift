//
//  DrumPadHostViewController.swift
//  MobileLab
//
//  Created by Jerry on 12/4/21.
//

import UIKit

class DrumPadHostViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var masterVolumePercentageLabel: UILabel!{
        didSet{
            masterVolumePercentageLabel.accessibilityIdentifier = "MASTER_VOLUME_PERCENTAGE_LABEL"
        }
    }
    @IBOutlet weak var masterVolumeFader: UISlider! {
        didSet{
            masterVolumeFader.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
            masterVolumeFader.accessibilityIdentifier = "MASTER_VOLUME_FADER"
        }
    }
    @IBOutlet weak var masterLabel: UILabel!{
        didSet{
            masterLabel.accessibilityIdentifier = "MASTER_LABEL"
        }
    }
    @IBOutlet weak var drumPadSoundBankSegmetControl: UISegmentedControl!{
        didSet{
            drumPadSoundBankSegmetControl.accessibilityIdentifier = "DRUM_PAD_SOUND_BANK_SEGMENT_CONTROL"
        }
    }
    
    var soundEngineManager = SoundEngineManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
    
    //MARK: Master Fader View Actions
    @IBAction func changeMasterVolume(_ sender: Any) {
        print("Master Volume = \(masterVolumeFader.value)")
        masterVolumePercentageLabel.text = "\(Int(masterVolumeFader.value * 100))%"
    }
}
