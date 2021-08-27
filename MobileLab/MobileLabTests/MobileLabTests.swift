//
//  MobileLabTests.swift
//  MobileLabTests
//
//  Created by Jerry on 8/25/21.
//

import XCTest
@testable import MobileLab

class MobileLabTests: XCTestCase {
    let soundGenerator = SoundGeneratorModel(generatorName: nil)
    
    func test_CreateNewSoundGenerator_withGivenName() throws {
        let kickSoundGenerator = SoundGeneratorModel(generatorName: "Kick")

        XCTAssertEqual(kickSoundGenerator.name, "Kick")
    }
    
    
    func test_CreateNewSoundGenerator_verifyDefaultValues() throws {
                
        XCTAssertEqual(soundGenerator.name, "Sample")
        XCTAssertEqual(soundGenerator.volume, 1.0)
        XCTAssertEqual(soundGenerator.pan, 0.0)
        XCTAssertEqual(soundGenerator.audioFile, nil)
    }
}
