//
//  SoundSourceTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/26/21.
//

import XCTest
@testable import SoundEngine

class SoundSourceModelTests: XCTestCase {

    func test_CreateNewSoundSourceModel() {
        let kickSoundSource = SoundSourceModel(sourceName: "Kick File")
        
        XCTAssertEqual(kickSoundSource.name, "Kick File")
        XCTAssertNotNil(kickSoundSource)
    }
    
    func test_loadAudioSampleToSoundSourceModel() {
        let sampleSoundSource = SoundSourceModel()
        
        sampleSoundSource.loadSampleFile(filePath: "foolishness ext 2", fileExtension: "mp3")
        XCTAssertNotNil(sampleSoundSource.audioFile)
        
    }

}
