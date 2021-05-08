// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// Analogue model of the Korg 35 Lowpass Filter
public class KorgLowPassFilter: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "klpf"
    public static let ComponentDescription = AudioComponentDescription(effect: "klpf")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    let input: Node
    override public var connections: [Node] { [input] }

    // MARK: - Parameters

    /// Specification details for cutoffFrequency
    public static let cutoffFrequencyDef = NodeParameterDef(
        identifier: "cutoffFrequency",
        name: "Filter cutoff",
        address: akGetParameterAddress("KorgLowPassFilterParameterCutoffFrequency"),
        defaultValue: 1_000.0,
        range: 0.0 ... 22_050.0,
        unit: .hertz,
        flags: .default)

    /// Filter cutoff
    @Parameter(cutoffFrequencyDef) public var cutoffFrequency: AUValue

    /// Specification details for resonance
    public static let resonanceDef = NodeParameterDef(
        identifier: "resonance",
        name: "Filter resonance (should be between 0-2)",
        address: akGetParameterAddress("KorgLowPassFilterParameterResonance"),
        defaultValue: 1.0,
        range: 0.0 ... 2.0,
        unit: .generic,
        flags: .default)

    /// Filter resonance (should be between 0-2)
    @Parameter(resonanceDef) public var resonance: AUValue

    /// Specification details for saturation
    public static let saturationDef = NodeParameterDef(
        identifier: "saturation",
        name: "Filter saturation.",
        address: akGetParameterAddress("KorgLowPassFilterParameterSaturation"),
        defaultValue: 0.0,
        range: 0.0 ... 10.0,
        unit: .generic,
        flags: .default)

    /// Filter saturation.
    @Parameter(saturationDef) public var saturation: AUValue

    // MARK: - Initialization

    /// Initialize this filter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - cutoffFrequency: Filter cutoff
    ///   - resonance: Filter resonance (should be between 0-2)
    ///   - saturation: Filter saturation.
    ///
    public init(
        _ input: Node,
        cutoffFrequency: AUValue = cutoffFrequencyDef.defaultValue,
        resonance: AUValue = resonanceDef.defaultValue,
        saturation: AUValue = saturationDef.defaultValue
        ) {
        self.input = input
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
               fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.cutoffFrequency = cutoffFrequency
            self.resonance = resonance
            self.saturation = saturation
        }
   }
}
