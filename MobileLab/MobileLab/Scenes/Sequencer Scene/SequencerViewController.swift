//
//  SequencerViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/5/22.
//

import UIKit

class SequencerViewController: UIViewController {
    
    //MARK: Properties
    var soundEngineManager = SoundEngineManager()
    @IBOutlet weak var transportControlsViewContainer: UIView!
    
    let transportControlsVC = TransportControlsViewController(nibName: "TransportViewController", bundle: nil)
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        transportControlsVC.addTransportControlsViewController(hostViewController: self, hostViewContainer: transportControlsViewContainer)
    }
    
    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
}
