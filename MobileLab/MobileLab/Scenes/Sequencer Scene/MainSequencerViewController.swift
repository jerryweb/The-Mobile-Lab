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
    
    private var transportControlsVC : TransportControlsViewController?
    var stepSequencerVC = StepSequencerViewController(nibName: "StepSequencerView", bundle: nil)
    
    //MARK: Functions
    override func viewDidLoad() {
        stepSequencerVC.soundEngineManager = soundEngineManager
        super.viewDidLoad()
        guard let transportControlsVC = transportControlsVC else {
            print("No transport controls view controller found!")
            return
        }
        transportControlsVC.embedSubVC(
            hostViewController: self,
            hostViewContainer: transportControlsViewContainer,
            childViewController: transportControlsVC,
            childView: transportControlsVC.view
        )
        
        stepSequencerVC.embedSubVC(
            hostViewController: self,
            hostViewContainer: sequencerScrollView,
            childViewController: stepSequencerVC,
            childView: stepSequencerVC.view
        )
        
        stepSequencerVC.soundEngineManager = soundEngineManager
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        stepSequencerVC.soundEngineManager = soundEngineManager
    }
}

extension MainSequencerViewController: AudioViewController {
    func setChildUIViewController(childViewController: UIViewController) {
        self.transportControlsVC = childViewController as? TransportControlsViewController
    }
}

