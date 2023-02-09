// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import Utilities

/// AudioKit version of Apple's Distortion Audio Unit
///
public class Distortion: Node {
    public var au: AUAudioUnit

    let input: Node

    /// Connected nodes
    public var connections: [Node] { [input] }

    /// Specification details for delay
    public static let delayDef = NodeParameterDef(
        identifier: "delay",
        name: "Delay",
        address: AUParameterAddress(kDistortionParam_Delay),
        defaultValue: 0.1,
        range: 0.1 ... 500,
        unit: .milliseconds
    )

    /// Delay (Milliseconds) ranges from 0.1 to 500 (Default: 0.1)
    @Parameter(delayDef) public var delay: AUValue

    /// Specification details for decay
    public static let decayDef = NodeParameterDef(
        identifier: "decay",
        name: "Decay",
        address: AUParameterAddress(kDistortionParam_Decay),
        defaultValue: 1.0,
        range: 0.1 ... 50,
        unit: .rate
    )

    /// Decay (Rate) ranges from 0.1 to 50 (Default: 1.0)
    @Parameter(decayDef) public var decay: AUValue

    /// Specification details for delayMix
    public static let delayMixDef = NodeParameterDef(
        identifier: "delayMix",
        name: "Delay Mix",
        address: AUParameterAddress(kDistortionParam_DelayMix),
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent
    )

    /// Delay Mix (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(delayMixDef) public var delayMix: AUValue

    /// Specification details for ringModFreq1
    public static let ringModFreq1Def = NodeParameterDef(
        identifier: "ringModFreq1",
        name: "Ring Mod Freq1",
        address: AUParameterAddress(kDistortionParam_RingModFreq1),
        defaultValue: 100,
        range: 0.5 ... 8000,
        unit: .hertz
    )

    /// Ring Mod Freq1 (Hertz) ranges from 0.5 to 8000 (Default: 100)
    @Parameter(ringModFreq1Def) public var ringModFreq1: AUValue

    /// Specification details for ringModFreq2
    public static let ringModFreq2Def = NodeParameterDef(
        identifier: "ringModFreq2",
        name: "Ring Mod Freq2",
        address: AUParameterAddress(kDistortionParam_RingModFreq2),
        defaultValue: 100,
        range: 0.5 ... 8000,
        unit: .hertz
    )

    /// Ring Mod Freq2 (Hertz) ranges from 0.5 to 8000 (Default: 100)
    @Parameter(ringModFreq2Def) public var ringModFreq2: AUValue

    /// Specification details for ringModBalance
    public static let ringModBalanceDef = NodeParameterDef(
        identifier: "ringModBalance",
        name: "Ring Mod Balance",
        address: AUParameterAddress(kDistortionParam_RingModBalance),
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent
    )

    /// Ring Mod Balance (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(ringModBalanceDef) public var ringModBalance: AUValue

    /// Specification details for ringModMix
    public static let ringModMixDef = NodeParameterDef(
        identifier: "ringModMix",
        name: "Ring Mod Mix",
        address: AUParameterAddress(kDistortionParam_RingModMix),
        defaultValue: 0,
        range: 0 ... 100,
        unit: .percent
    )

    /// Ring Mod Mix (Percent) ranges from 0 to 100 (Default: 0)
    @Parameter(ringModMixDef) public var ringModMix: AUValue

    /// Specification details for decimation
    public static let decimationDef = NodeParameterDef(
        identifier: "decimation",
        name: "Decimation",
        address: AUParameterAddress(kDistortionParam_Decimation),
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent
    )

    /// Decimation (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(decimationDef) public var decimation: AUValue

    /// Specification details for rounding
    public static let roundingDef = NodeParameterDef(
        identifier: "rounding",
        name: "Rounding",
        address: AUParameterAddress(kDistortionParam_Rounding),
        defaultValue: 0,
        range: 0 ... 100,
        unit: .percent
    )

    /// Rounding (Percent) ranges from 0 to 100 (Default: 0)
    @Parameter(roundingDef) public var rounding: AUValue

    /// Specification details for decimationMix
    public static let decimationMixDef = NodeParameterDef(
        identifier: "decimationMix",
        name: "Decimation Mix",
        address: AUParameterAddress(kDistortionParam_DecimationMix),
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent
    )

    /// Decimation Mix (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(decimationMixDef) public var decimationMix: AUValue

    /// Specification details for linearTerm
    public static let linearTermDef = NodeParameterDef(
        identifier: "linearTerm",
        name: "Linear Term",
        address: AUParameterAddress(kDistortionParam_LinearTerm),
        defaultValue: 0.5,
        range: 0 ... 1,
        unit: .linearGain
    )

    /// Linear Term (Percent) ranges from 0 to 1 (Default: 0.5)
    @Parameter(linearTermDef) public var linearTerm: AUValue

    /// Specification details for squaredTerm
    public static let squaredTermDef = NodeParameterDef(
        identifier: "squaredTerm",
        name: "Squared Term",
        address: AUParameterAddress(kDistortionParam_SquaredTerm),
        defaultValue: 10,
        range: 0 ... 20,
        unit: .linearGain
    )

    /// Squared Term (Percent) ranges from 0 to 20 (Default: 10)
    @Parameter(squaredTermDef) public var squaredTerm: AUValue

    /// Specification details for cubicTerm
    public static let cubicTermDef = NodeParameterDef(
        identifier: "cubicTerm",
        name: "Cubic Term",
        address: AUParameterAddress(kDistortionParam_CubicTerm),
        defaultValue: 10,
        range: 0 ... 20,
        unit: .linearGain
    )

    /// Cubic Term (Percent) ranges from 0 to 20 (Default: 10)
    @Parameter(cubicTermDef) public var cubicTerm: AUValue

    /// Specification details for polynomialMix
    public static let polynomialMixDef = NodeParameterDef(
        identifier: "polynomialMix",
        name: "Polynomial Mix",
        address: AUParameterAddress(kDistortionParam_PolynomialMix),
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent
    )

    /// Polynomial Mix (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(polynomialMixDef) public var polynomialMix: AUValue

    /// Specification details for softClipGain
    public static let softClipGainDef = NodeParameterDef(
        identifier: "softClipGain",
        name: "Soft Clip Gain",
        address: AUParameterAddress(kDistortionParam_SoftClipGain),
        defaultValue: -6,
        range: -80 ... 20,
        unit: .decibels
    )

    /// Soft Clip Gain (decibels) ranges from -80 to 20 (Default: -6)
    @Parameter(softClipGainDef) public var softClipGain: AUValue

    /// Specification details for finalMix
    public static let finalMixDef = NodeParameterDef(
        identifier: "finalMix",
        name: "Final Mix",
        address: AUParameterAddress(kDistortionParam_FinalMix),
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent
    )

    /// Final Mix (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(finalMixDef) public var finalMix: AUValue

    /// Load an Apple Factory Preset
    public func loadFactoryPreset(_ preset: DistortionPreset) {
        let auPreset = AUAudioUnitPreset()
        auPreset.number = preset.rawValue
        au.currentPreset = auPreset
    }

    /// Initialize the distortion node
    ///
    /// - parameter input: Input node to process
    /// - parameter delay: Delay (Milliseconds) ranges from 0.1 to 500 (Default: 0.1)
    /// - parameter decay: Decay (Rate) ranges from 0.1 to 50 (Default: 1.0)
    /// - parameter delayMix: Delay Mix (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter ringModFreq1: Ring Mod Freq1 (Hertz) ranges from 0.5 to 8000 (Default: 100)
    /// - parameter ringModFreq2: Ring Mod Freq2 (Hertz) ranges from 0.5 to 8000 (Default: 100)
    /// - parameter ringModBalance: Ring Mod Balance (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter ringModMix: Ring Mod Mix (Percent) ranges from 0 to 100 (Default: 0)
    /// - parameter decimation: Decimation (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter rounding: Rounding (Percent) ranges from 0 to 100 (Default: 0)
    /// - parameter decimationMix: Decimation Mix (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter linearTerm: Linear Term (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter squaredTerm: Squared Term (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter cubicTerm: Cubic Term (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter polynomialMix: Polynomial Mix (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter softClipGain: Soft Clip Gain (decibels) ranges from -80 to 20 (Default: -6)
    /// - parameter finalMix: Final Mix (Percent) ranges from 0 to 100 (Default: 50)
    ///
    public init(
        _ input: Node,
        delay: AUValue = delayDef.defaultValue,
        decay: AUValue = decayDef.defaultValue,
        delayMix: AUValue = delayMixDef.defaultValue,
        ringModFreq1: AUValue = ringModFreq1Def.defaultValue,
        ringModFreq2: AUValue = ringModFreq2Def.defaultValue,
        ringModBalance: AUValue = ringModBalanceDef.defaultValue,
        ringModMix: AUValue = ringModMixDef.defaultValue,
        decimation: AUValue = decimationDef.defaultValue,
        rounding: AUValue = roundingDef.defaultValue,
        decimationMix: AUValue = decimationMixDef.defaultValue,
        linearTerm: AUValue = linearTermDef.defaultValue,
        squaredTerm: AUValue = squaredTermDef.defaultValue,
        cubicTerm: AUValue = cubicTermDef.defaultValue,
        polynomialMix: AUValue = polynomialMixDef.defaultValue,
        softClipGain: AUValue = softClipGainDef.defaultValue,
        finalMix: AUValue = finalMixDef.defaultValue
    ) {
        self.input = input

        let desc = AudioComponentDescription(appleEffect: kAudioUnitSubType_Distortion)
        au = instantiateAU(componentDescription: desc)
        associateParams(with: au)

        self.delay = delay
        self.decay = decay
        self.delayMix = delayMix
        self.ringModFreq1 = ringModFreq1
        self.ringModFreq2 = ringModFreq2
        self.ringModBalance = ringModBalance
        self.ringModMix = ringModMix
        self.decimation = decimation
        self.rounding = rounding
        self.decimationMix = decimationMix
        self.linearTerm = linearTerm
        self.squaredTerm = squaredTerm
        self.cubicTerm = cubicTerm
        self.polynomialMix = polynomialMix
        self.softClipGain = softClipGain
        self.finalMix = finalMix
    }
}

public enum DistortionPreset: Int, CaseIterable, CustomStringConvertible {
    case drumsBitBrush
    case drumsBufferBeats
    case drumsLoFi
    case multiBrokenSpeaker
    case multiCellphoneConcert
    case multiDecimated1
    case multiDecimated2
    case multiDecimated3
    case multiDecimated4
    case multiDistortedFunk
    case multiDistortedCubed
    case multiDistortedSquared
    case multiEcho1
    case multiEcho2
    case multiEchoTight1
    case multiEchoTight2
    case multiEverythingIsBroken
    case speechAlienChatter
    case speechCosmicInterference
    case speechGoldenPi
    case speechRadioTower
    case speechWaves

    public var name: String {
        switch self {
            case .drumsBitBrush:
                return "Drums Bit Brush"
            case .drumsBufferBeats:
                return "Drums Buffer Beats"
            case .drumsLoFi:
                return "Drums LoFi"
            case .multiBrokenSpeaker:
                return "Multi-Broken Speaker"
            case .multiCellphoneConcert:
                return "Multi-Cellphone Concert"
            case .multiDecimated1:
                return "Multi-Decimated 1"
            case .multiDecimated2:
                return "Multi-Decimated 2"
            case .multiDecimated3:
                return "Multi-Decimated 3"
            case .multiDecimated4:
                return "Multi-Decimated 4"
            case .multiDistortedFunk:
                return "Multi-Distorted Funk"
            case .multiDistortedCubed:
                return "Multi-Distorted Cubed"
            case .multiDistortedSquared:
                return "Multi-Distorted Squared"
            case .multiEcho1:
                return "Multi-Echo 1"
            case .multiEcho2:
                return "Multi-Echo 2"
            case .multiEchoTight1:
                return "Multi-Echo Tight 1"
            case .multiEchoTight2:
                return "Multi-Echo Tight 2"
            case .multiEverythingIsBroken:
                return "Multi-Everything Is Broken"
            case .speechAlienChatter:
                return "Speech Alien Chatter"
            case .speechCosmicInterference:
                return "Speech Cosmic Interference"
            case .speechGoldenPi:
                return "Speech Golden Pi"
            case .speechRadioTower:
                return "Speech Radio Tower"
            case .speechWaves:
                return "Speech Waves"
        }
    }

    public var description: String {
        return name
    }
}
