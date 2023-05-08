// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
import AudioKit
import AVFoundation
import XCTest

class RecorderTests: AKTestCase {

    @MainActor
    func testBasicRecord() throws {

        let mgr = FileManager.default
        var audioFileURL = mgr.temporaryDirectory.appendingPathComponent("testBasicRecord.aiff", conformingTo: .aiff)

        try? mgr.removeItem(at: audioFileURL)

        let scope = {
            let engine = Engine()
            let sampler = Sampler()
            engine.output = sampler

            let format = AVAudioFormat(standardFormatWithSampleRate: 44100,
                                       channels: 2)!

            let file = try AVAudioFile(forWriting: audioFileURL, settings: format.settings)
            let recorder = Recorder2(node: sampler, file: file)

            recorder.isPaused = false

            // record a little audio
            try engine.start()
            sampler.play(url: .testAudio)

            RunLoop.main.run(until: .now+1.0)

            XCTAssertGreaterThan(file.length, 1024)

        }

        try scope()

        print("audioFileURL: \(audioFileURL)")
        let file = try AVAudioFile(forReading: audioFileURL)
        XCTAssertGreaterThan(file.length, 1024)
        XCTAssertFalse(file.toAVAudioPCMBuffer()!.isSilent)

    }
//
//    func testCallback() throws {
//        return // for now, tests are failing
//        let engine = Engine()
//        let sampler = Sampler()
//        engine.output = sampler
//        let recorder = try NodeRecorder(node: sampler)
//
//        // attach the callback handler
//        var values = [Float]()
//        recorder.audioDataCallback = { audioData, _ in
//            values.append(contentsOf: audioData)
//        }
//
//        // record a little audio
//        try engine.start()
//        sampler.play(url: .testAudio)
//        try recorder.reset()
//        try recorder.record()
//        sleep(1)
//
//        // stop recording and load it into a player
//        recorder.stop()
//        let audioFileURL = recorder.audioFile!.url
//        engine.stop()
//        sampler.stop()
//
//        // test the result
//        let audio = engine.startTest(totalDuration: 1.0)
//        sampler.play(url: audioFileURL)
//        audio.append(engine.render(duration: 1.0))
//        XCTAssertEqual(values[5000], -0.027038574)
//    }
}
