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
    
    // MARK: Drum Pad View
    @IBOutlet weak var drumPad0: UIButton! {
        didSet{
            drumPad0.accessibilityIdentifier = "DRUM_PAD_0"
            drumPad0.layer.cornerRadius = 10
            drumPad0.layer.shadowOpacity = 1
            drumPad0.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    @IBOutlet weak var drumPad1: UIButton!{
        didSet{
            drumPad1.accessibilityIdentifier = "DRUM_PAD_1"
            drumPad1.layer.cornerRadius = 10
            drumPad1.layer.shadowOpacity = 1
            drumPad1.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBOutlet weak var drumPad2: UIButton!{
        didSet{
            drumPad2.accessibilityIdentifier = "DRUM_PAD_2"
            drumPad2.layer.cornerRadius = 10
            drumPad2.layer.shadowOpacity = 1
            drumPad2.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBOutlet weak var drumPad3: UIButton!{
        didSet{
            drumPad3.accessibilityIdentifier = "DRUM_PAD_3"
            drumPad3.layer.cornerRadius = 10
            drumPad3.layer.shadowOpacity = 1
            drumPad3.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBOutlet weak var drumPad4: UIButton!{
        didSet{
            drumPad4.accessibilityIdentifier = "DRUM_PAD_4"
            drumPad4.layer.cornerRadius = 10
            drumPad4.layer.shadowOpacity = 1
            drumPad4.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }

    @IBOutlet weak var drumPad5: UIButton!{
        didSet{
            drumPad5.accessibilityIdentifier = "DRUM_PAD_5"
            drumPad5.layer.cornerRadius = 10
            drumPad5.layer.shadowOpacity = 1
            drumPad5.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBOutlet weak var drumPad6: UIButton!{
        didSet{
            drumPad6.accessibilityIdentifier = "DRUM_PAD_6"
            drumPad6.layer.cornerRadius = 10
            drumPad6.layer.shadowOpacity = 1
            drumPad6.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBOutlet weak var drumPad7: UIButton!{
        didSet{
            drumPad7.accessibilityIdentifier = "DRUM_PAD_7"
            drumPad7.layer.cornerRadius = 10
            drumPad7.layer.shadowOpacity = 1
            drumPad7.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    var soundEngineManager = SoundEngineManager()
    let transportControlsVC = TransportControlsViewController()
    @IBOutlet weak var transportControlsViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTransportControlsViewController()
    }
    
    func addTransportControlsViewController(){
        transportControlsViewContainer.addSubview(transportControlsVC.view)
        
        // layout constraint.activate
        addChild(transportControlsVC)
        transportControlsVC.view.backgroundColor = .systemYellow
        view.addSubview(transportControlsVC.view)
        transportControlsVC.didMove(toParent: self)
    }
    
    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
    
    //MARK: Master Fader View Actions
    @IBAction func changeMasterVolume(_ sender: Any) {
        print("Master Volume = \(masterVolumeFader.value)")
        masterVolumePercentageLabel.text = "\(Int(masterVolumeFader.value * 100))%"
    }
    
    //MARK: Drum Pad View Actions
    @IBAction func tapDrumPad0(_ sender: Any) {
        print("tapped drum pad 0")
        soundEngineManager.playChannel(0)
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
