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
    @IBOutlet weak var drumPad0: UIButton!
    
    @IBOutlet weak var materVolumeFader: UISlider! {
        didSet{
            materVolumeFader.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapDrumPad0(_ sender: Any) {
        print("tapped drum pad 0")

    }
}

//public class AudioFileSpy  {
//    
//    var audioFile : AVAudioFile?
//    var audioFile2 : AVAudioFile?
//    
//    let filePath = "Heavy Kick"
//    let fileExtension = "wav"
//    
//    let filePath2 = "swellen horns"
//    let fileExtension2 = "mp3"
//    
//    public init(){
//        let testBundle = Bundle(for: type(of: self))
//
//        guard let url = testBundle.url(forResource: filePath, withExtension: fileExtension)
//        else {
//            print("Unable to load audio file: \(filePath)")
//            return
//        }
//        
//        do {
//            let file = try AVAudioFile(forReading: url)
//            audioFile = file
//        }
//        catch {
//            print("Unable to read audio file \(error.localizedDescription)")
//        }
//        
//        guard let url = testBundle.url(forResource: filePath2, withExtension: fileExtension2)
//        else {
//            print("Unable to load audio file: \(filePath2)")
//            return
//        }
//        
//        do {
//            let file = try AVAudioFile(forReading: url)
//            audioFile2 = file
//        }
//        catch {
//            print("Unable to read audio file \(error.localizedDescription)")
//        }
//    }
//}
