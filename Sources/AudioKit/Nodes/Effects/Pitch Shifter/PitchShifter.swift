// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// Faust-based pitch shfiter
public class PitchShifter: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "pshf"
    public static let ComponentDescription = AudioComponentDescription(effect: "pshf")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    let input: Node
    override public var connections: [Node] { [input] }

    // MARK: - Parameters

    /// Specification details for shift
    public static let shiftDef = NodeParameterDef(
        identifier: "shift",
        name: "Pitch shift (in semitones)",
        address: akGetParameterAddress("PitchShifterParameterShift"),
        defaultValue: 0,
        range: -24.0 ... 24.0,
        unit: .relativeSemiTones,
        flags: .default)

    /// Pitch shift (in semitones)
    @Parameter(shiftDef) public var shift: AUValue

    /// Specification details for windowSize
    public static let windowSizeDef = NodeParameterDef(
        identifier: "windowSize",
        name: "Window size (in samples)",
        address: akGetParameterAddress("PitchShifterParameterWindowSize"),
        defaultValue: 1_024,
        range: 0.0 ... 10_000.0,
        unit: .hertz,
        flags: .default)

    /// Window size (in samples)
    @Parameter(windowSizeDef) public var windowSize: AUValue

    /// Specification details for crossfade
    public static let crossfadeDef = NodeParameterDef(
        identifier: "crossfade",
        name: "Crossfade (in samples)",
        address: akGetParameterAddress("PitchShifterParameterCrossfade"),
        defaultValue: 512,
        range: 0.0 ... 10_000.0,
        unit: .hertz,
        flags: .default)

    /// Crossfade (in samples)
    @Parameter(crossfadeDef) public var crossfade: AUValue

    // MARK: - Initialization

    /// Initialize this pitchshifter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - shift: Pitch shift (in semitones)
    ///   - windowSize: Window size (in samples)
    ///   - crossfade: Crossfade (in samples)
    ///
    public init(
        _ input: Node,
        shift: AUValue = shiftDef.defaultValue,
        windowSize: AUValue = windowSizeDef.defaultValue,
        crossfade: AUValue = crossfadeDef.defaultValue
        ) {
        self.input = input
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
               fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.shift = shift
            self.windowSize = windowSize
            self.crossfade = crossfade
        }
   }
}
