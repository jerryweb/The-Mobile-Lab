//
//  StepSequencerViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/9/22.
//

import UIKit

class StepSequencerViewController: UIViewController {

    //MARK: Properties
    var soundEngineManager = SoundEngineManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
    
    func addStepSequencerViewController(hostViewController: UIViewController, hostViewContainer: UIView){
        
        hostViewController.addChild(self)
        hostViewContainer.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
                
        hostViewContainer.addConstraints([
            view.leadingAnchor.constraint(equalTo: hostViewContainer.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: hostViewContainer.trailingAnchor),
            view.topAnchor.constraint(equalTo: hostViewContainer.topAnchor),
            view.bottomAnchor.constraint(equalTo: hostViewContainer.bottomAnchor)
        ])
        
        self.didMove(toParent: self)
    }

}
