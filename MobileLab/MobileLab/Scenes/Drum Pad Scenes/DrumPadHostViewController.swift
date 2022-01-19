//
//  DrumPadHostViewController.swift
//  MobileLab
//
//  Created by Jerry on 12/4/21.
//

import UIKit

class DrumPadHostViewController: UIViewController {
    
    //MARK: Properties
    var selectedSoundBank = 0 // this represents the current bank of 8 sounds that are loaded into a beat pad
    let maxDrumPads = 8
    var soundEngineManager = SoundEngineManager()
    private var transportControlsVC : TransportControlsViewController?
    
    // MARK: Outlets
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
    
    @IBOutlet weak var transportControlsViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let transportControlsVC = transportControlsVC else {
            print("No transport controls view controller found")
            return
        }
        transportControlsVC.embedSubVC(
            hostViewController: self,
            hostViewContainer: transportControlsViewContainer,
            childViewController: transportControlsVC,
            childView: transportControlsVC.view
        )
        
        updateMasterVolumeViews(
            masterVolumeFader: masterVolumeFader,
            masterVolumePercentageLabel: masterVolumePercentageLabel
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard  let transportControlsVC = transportControlsVC else {
            print("No transport controls view controller found")
            return
        }
        transportControlsVC.embedSubVC(
            hostViewController: self,
            hostViewContainer: transportControlsViewContainer,
            childViewController: transportControlsVC,
            childView: transportControlsVC.view
        )
        
        updateMasterVolumeViews(
            masterVolumeFader: masterVolumeFader,
            masterVolumePercentageLabel: masterVolumePercentageLabel
        )
    }
    
    //MARK: Master Fader View Actions
    @IBAction func changeMasterVolume(_ sender: Any) {
        setMasterVolume(
            vol: masterVolumeFader.value,
            masterVolumeFader: masterVolumeFader,
            masterVolumePercentageLabel: masterVolumePercentageLabel
        )
    }
    
    //MARK: Drum Pad View Actions
    @IBAction func tapDrumPad0(_ sender: Any) {
        
        print("tapped drum pad 0")
        soundEngineManager.playChannel(0 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapDrumPad1(_ sender: Any) {
        print("tapped drum pad 1")
        soundEngineManager.playChannel(1 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapDrumPad2(_ sender: Any) {
        print("tapped drum pad 2")
        soundEngineManager.playChannel(2 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapDrumPad3(_ sender: Any) {
        print("tapped drum pad 3")
        soundEngineManager.playChannel(3 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapDrumPad4(_ sender: Any) {
        print("tapped drum pad 4")
        soundEngineManager.playChannel(4 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapDrumPad5(_ sender: Any) {
        print("tapped drum pad 5")
        soundEngineManager.playChannel(5 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapDrumPad6(_ sender: Any) {
        print("tapped drum pad 6")
        soundEngineManager.playChannel(6 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapDrumPad7(_ sender: Any) {
        print("tapped drum pad 7")
        soundEngineManager.playChannel(7 + (selectedSoundBank * maxDrumPads))
    }
    
    @IBAction func tapdrumPadSoundBankSegmetControl(_ sender: Any) {
        selectedSoundBank = drumPadSoundBankSegmetControl.selectedSegmentIndex
        print("Switched to sound bank \(selectedSoundBank)")
    }
    
}

//MARK: extensions
extension DrumPadHostViewController: AudioViewController {
    func setChildUIViewController(childViewController: UIViewController) {
        self.transportControlsVC = childViewController as? TransportControlsViewController
    }
}
