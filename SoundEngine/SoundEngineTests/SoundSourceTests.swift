//
//  SoundSourceTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/26/21.
//

import XCTest
import AVFoundation
@testable import SoundEngine

class SoundSourceModelTests: XCTestCase {

    func test_CreateDefaultSoundSouceModel() {
        let sampleSoundSource = SoundSoucrceSpy()
        XCTAssertEqual(sampleSoundSource.name, "Sample")
        XCTAssertNil(sampleSoundSource.audioFile)
    }
    
    func test_CreateNewSoundSourceModel() {
        let kickSoundSource = SoundSoucrceSpy(sourceName: "Kick File")
        
        XCTAssertEqual(kickSoundSource.name, "Kick File")
        XCTAssertNil(kickSoundSource.audioFile)
    }
    
    func test_CreateSoundSouceWithAudioFile() {
        let av = AudioFileSpy()
        av.createAudioFile()
        av.grabAudioFile()
        let songSoundSource = SoundSoucrceSpy(sampleFile: av.audioFile!)
        print(songSoundSource.audioFile?.description)
        XCTAssertEqual(songSoundSource.name, "basic_kick")
        XCTAssertNotNil(songSoundSource.audioFile)
    }
    
    func test_loadAudioSampleToSoundSourceModel() {
        let sampleSoundSource = SoundSoucrceSpy()
        sampleSoundSource.setAudioSample(AVAudioFile())
        XCTAssertNotNil(sampleSoundSource.audioFile)
        
    }
    
    // MARK: - Helpers
    class AudioFileSpy {
        
        var audioFile : AVAudioFile?
        
        func createAudioFile(){
            let manager = FileManager.default
            guard var url = manager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else {
                print("Failed to load file manager url.")
                return
            }
            
            url.appendPathComponent("basic_kick.mp3")
            manager.createFile(atPath: url.path,
                               contents: nil,
                               attributes: [FileAttributeKey.type : "mp3"])
        }
        
        func grabAudioFile() {
            do {
                let manager = FileManager.default
                guard var url = manager.urls(for: .documentDirectory,
                                             in: .userDomainMask).first else {
                    print("Failed to load sample file")
                    return
                }
                
    
                url.appendPathComponent("basic_kick")
                url.appendPathExtension("mp3")
                
                print(url)
                let file = try AVAudioFile(forReading: url)
                audioFile = file
    
            } catch {
                print("Unableasdfafsfa to read audio file \(error.localizedDescription)")
            }
        }
        
        
    }
    class SoundSoucrceSpy : SoundSourceModel {
        


        
    }

}
