//
//  AudioFileSpy.swift
//  SoundEngineTests
//
//  Created by Jerry on 10/23/21.
//

import Foundation
import AVFoundation


class AudioFileSpy  {
    
    var audioFile : AVAudioFile?
    var audioFile2 : AVAudioFile?
    
    let filePath = "Heavy Kick"
    let fileExtension = "wav"
    
    let filePath2 = "swellen horns"
    let fileExtension2 = "mp3"
    
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

