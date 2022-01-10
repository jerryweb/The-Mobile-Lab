//
//  SequencerViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/5/22.
//

import UIKit

class MainSequencerViewController: UIViewController {
    
    //MARK: Properties
    var soundEngineManager = SoundEngineManager()
    @IBOutlet weak var transportControlsViewContainer: UIView!
    @IBOutlet weak var sequencerScrollView: UIScrollView!
    
    let transportControlsVC = TransportControlsViewController(nibName: "TransportViewController", bundle: nil)
    let stepSequencerVC = StepSequencerViewController(nibName: "StepSequencerView", bundle: nil)
    
    

    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        transportControlsVC.addTransportControlsViewController(hostViewController: self, hostViewContainer: transportControlsViewContainer)
        stepSequencerVC.addStepSequencerViewController(hostViewController: self, hostViewContainer: sequencerScrollView)
        stepSequencerVC.setUp(soundEngineManager: soundEngineManager)
    }
    
    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
}
