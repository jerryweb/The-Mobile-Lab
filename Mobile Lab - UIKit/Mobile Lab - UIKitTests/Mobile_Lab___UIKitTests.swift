//___FILEHEADER___

import XCTest
@testable import Mobile_Lab___UIKit

class SoundGeneratorModelTests: XCTestCase {
    let soundGenerator = SoundGeneratorModel(generatorName: nil)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
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
    
//    func test_CreateNewSoundGenerator_loadSampleFile() throws {
//                
//        XCTAssertEqual(soundGenerator.audioFile, !nil)
//    }
    
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
