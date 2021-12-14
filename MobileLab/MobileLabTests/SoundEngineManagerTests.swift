//
//  SoundEngineManagerTests.swift
//  MobileLabTests
//
//  Created by Jerry on 12/13/21.
//

import XCTest
@testable import MobileLab

class SoundEngineManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CreateSoundEngineManager() throws {
        let soundEngineManager = SoundEngineManager()
        XCTAssertNotNil(soundEngineManager.playbackEngine)
    }

}
