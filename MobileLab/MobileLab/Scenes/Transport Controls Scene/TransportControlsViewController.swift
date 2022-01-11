//
//  TransportControlsViewController.swift
//  MobileLab
//  This view controller class contains all the buttons for audio transport such as play, pause, record and stop. Users can uses these controls to initiate and record a sequence or modify the beats per minute (bpm) which will change the speed of the sequence playback. It also displays which beat and bar the sequence is on if playing i.e. bar 4 beat 3
//  Created by Jerry on 12/1/21.
//
import UIKit
import Foundation

class TransportControlsViewController: UIViewController, EmbeddedSubViewController {
    
    //MARK: Outlets
    @IBOutlet weak var playButton: UIButton!{
        didSet{
            playButton.accessibilityIdentifier = "PLAY_BUTTON"
        }
    }
    
    @IBOutlet weak var pauseButton: UIButton!{
        didSet{
            pauseButton.accessibilityIdentifier = "PAUSE_BUTTON"
        }
    }
    
    @IBOutlet weak var stopButton: UIButton!{
        didSet{
            stopButton.accessibilityIdentifier = "STOP_BUTTON"
        }
    }
    
    @IBOutlet weak var recordButton: UIButton!{
        didSet{
            recordButton.accessibilityIdentifier = "RECORD_BUTTON"
        }
    }
    
    @IBOutlet weak var metronomeToggleButton: UIButton!{
        didSet{
            metronomeToggleButton.accessibilityIdentifier = "METRONOME_TOGGLE_BUTTON"
        }
    }
    
    @IBOutlet weak var bpmStepper: UIStepper!{
        didSet{
            bpmStepper.accessibilityIdentifier = "BPM_STEPPER"
        }
    }
    
    @IBOutlet weak var bpmTextLabel: UILabel!{
        didSet{
            bpmTextLabel.accessibilityIdentifier = "BPM_TEXT_LABEL"
        }
    }
    
    @IBOutlet weak var bpmTextField: UITextField!{
        didSet{
            bpmTextField.accessibilityIdentifier = "BPM_TEXT_FIELD"
        }
    }
    
    @IBOutlet weak var barValueLabael: UILabel!{
        didSet{
            barValueLabael.accessibilityIdentifier = "BAR_VALUE_LABEL"
        }
    }
    
    @IBOutlet weak var beatValueLabel: UILabel!{
        didSet{
            beatValueLabel.accessibilityIdentifier = "BEAT_VALUE_LABEL"
        }
    }
    
    //MARK: Properties
    var soundEngineManager = SoundEngineManager()
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
    
    //MARK: IB Outlets
    @IBAction func playButtonTapped(_ sender: Any) {
        soundEngineManager.engine.startSequence()
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
        soundEngineManager.engine.stopSequence()
    }
    @IBAction func stopButtonTapped(_ sender: Any) {
        soundEngineManager.engine.stopSequence()
    }
    
}
