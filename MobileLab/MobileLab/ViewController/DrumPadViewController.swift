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
//    @IBOutlet weak var pad0: UIButton!
//    @IBOutlet weak var pad1: UIButton!
//    @IBOutlet weak var pad2: UIButton!
//    @IBOutlet weak var pad3: UIButton!
//    @IBOutlet weak var pad4: UIButton!
//    @IBOutlet weak var pad5: UIButton!
//    @IBOutlet weak var pad6: UIButton!
//    @IBOutlet weak var pad7: UIButton!
    @IBOutlet weak var pad0: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapPad0(_ sender: Any) {
        print("tapped pad 0")
    }
    
    @IBAction func tapPad1(_ sender: Any) {
        print("tapped pad 1")
    }
    
    @IBAction func tapPad2(_ sender: Any) {
        print("tapped pad 2")
    }
    
    
    
}

public class AudioFileSpy  {
    
    var audioFile : AVAudioFile?
    var audioFile2 : AVAudioFile?
    
    let filePath = "Heavy Kick"
    let fileExtension = "wav"
    
    let filePath2 = "swellen horns"
    let fileExtension2 = "mp3"
    
    public init(){
        let testBundle = Bundle(for: type(of: self))

        guard let url = testBundle.url(forResource: filePath, withExtension: fileExtension)
        else {
            print("Unable to load audio file: \(filePath)")
            return
        }
        
        do {
            let file = try AVAudioFile(forReading: url)
            audioFile = file
        }
        catch {
            print("Unable to read audio file \(error.localizedDescription)")
        }
        
        guard let url = testBundle.url(forResource: filePath2, withExtension: fileExtension2)
        else {
            print("Unable to load audio file: \(filePath2)")
            return
        }
        
        do {
            let file = try AVAudioFile(forReading: url)
            audioFile2 = file
        }
        catch {
            print("Unable to read audio file \(error.localizedDescription)")
        }
    }
}
