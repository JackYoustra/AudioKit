// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class ExpanderTests: XCTestCase {
    func testDefault() throws {
        try XCTSkipIf(true, "TODO This test gives different results on local machines from what CI does")
        let engine = AudioEngine()
        let input = AudioPlayer(url: URL.testAudio)!
        engine.output = Expander(input)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }
}
