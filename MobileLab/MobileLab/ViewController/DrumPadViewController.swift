//
//  DrumPadViewController.swift
//  MobileLab
//
//  Created by Jerry on 11/16/21.
//

import UIKit
import SoundEngine
import AVFoundation

class DrumPadViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var drumPad0: UIButton!
    @IBOutlet weak var drumPad1: UIButton!
    @IBOutlet weak var drumpad2: UIButton!
    @IBOutlet weak var drumPad3: UIButton!
    @IBOutlet weak var drumPad4: UIButton!
    @IBOutlet weak var drumPad5: UIButton!
    @IBOutlet weak var drumPad6: UIButton!
    @IBOutlet weak var drumPad7: UIButton!
    
    @IBOutlet weak var masterVolumePercentageLabel: UILabel!
    @IBOutlet weak var masterVolumeFader: UISlider! {
        didSet{
            masterVolumeFader.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: Master Fader View Actions
    @IBAction func changeMasterVolume(_ sender: Any) {
        print("Master Volume = \(masterVolumeFader.value)")
        masterVolumePercentageLabel.text = "\(Int(masterVolumeFader.value * 100))%"
    }
    
    //MARK: Drum Pad View Actions
    @IBAction func tapDrumPad0(_ sender: Any) {
        print("tapped drum pad 0")
    }
    
    @IBAction func tapDrumPad1(_ sender: Any) {
        print("tapped drum pad 1")
    }
    
    @IBAction func tapDrumPad2(_ sender: Any) {
        print("tapped drum pad 2")
    }
    
    @IBAction func tapDrumPad3(_ sender: Any) {
        print("tapped drum pad 3")
    }
    
    @IBAction func tapDrumPad4(_ sender: Any) {
        print("tapped drum pad 4")
    }
    
    @IBAction func tapDrumPad5(_ sender: Any) {
        print("tapped drum pad 5")
    }
    
    @IBAction func tapDrumPad6(_ sender: Any) {
        print("tapped drum pad 6")
    }
    
    @IBAction func tapDrumPad7(_ sender: Any) {
        print("tapped drum pad 7")
    }
}
