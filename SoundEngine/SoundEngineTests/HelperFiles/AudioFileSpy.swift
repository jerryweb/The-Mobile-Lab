//
//  AudioFileSpy.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/23/21.
//

import Foundation
import AVFoundation

class AudioFileSpy {
    
    var audioFile : AVAudioFile?
    let filePath = "Heavy Kick"
    let fileExtension = "wav"
    
    init(){
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
    }
}

