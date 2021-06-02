//___FILEHEADER___

import XCTest
@testable import Mobile_Lab___UIKit

class SoundGeneratorModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CreateNewSoundGenerator_withNoGivenName() throws {
        
        let soundGenerator = SoundGeneratorModel(generatorName: nil)
        
        XCTAssertEqual(soundGenerator.name, "Sample")
    }
    
    func test_CreateNewSoundGenerator_withGivenName() throws {
        
        let soundGenerator = SoundGeneratorModel(generatorName: "Kick")
        
        XCTAssertEqual(soundGenerator.name, "Kick")
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
