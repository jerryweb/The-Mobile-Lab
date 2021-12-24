//
//  MainViewController.swift
//  MobileLab
//
//  Created by Jerry on 12/21/21.
//

import UIKit

class MainViewController: UIViewController {

    var soundEngineManager = SoundEngineManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }

}
