//
//  StepSequencerViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/9/22.
//

import UIKit

class StepSequencerViewController: UIViewController, EmbeddedSubViewController {

    //MARK: Outlets
    @IBOutlet weak var track00NameLabel: UILabel!
    @IBOutlet weak var track00MuteButton: UIButton!
    
    //MARK: Properties
    var soundEngineManager = SoundEngineManager()
    let dummyTracks = [1,2,3,4,5,6,7,8]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
    
    @IBAction func tappedTrack00MuteButton(_ sender: Any) {
        print("Toggling track 0 mute")
    }

}
