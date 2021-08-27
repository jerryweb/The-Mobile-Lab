//
//  SoundSourceTests.swift
//  SoundEngineTests
//
//  Created by Jerry on 8/26/21.
//

import XCTest
@testable import SoundEngine

class SoundSourceModelTests: XCTestCase {

    func test_CreateNewSoundSource() {
        let kickSoundSource = SoundSourceModel(sourceName: "Kick File")
        
        XCTAssertEqual(kickSoundSource.name, "Kick File")
        XCTAssertNotNil(kickSoundSource)
    }

}
