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
    
    @IBOutlet weak var materVolumeFader: UISlider! {
        didSet{
            materVolumeFader.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapDrumPad0(_ sender: Any) {
        print("tapped drum pad 0")

    }
}
