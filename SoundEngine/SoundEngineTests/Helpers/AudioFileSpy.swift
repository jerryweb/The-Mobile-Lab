//
//  AudioFile.swift
//  SoundEngineTests
//
//  Created by Jerry on 9/6/21.
//

import Foundation
import AVFoundation

// MARK: - Helpers
class AudioFileSpy {
    
    var audioFile : AVAudioFile?
    let filePath = "foolishness ext 2"
    let fileExtension = "mp3"
    
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
