// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// AudioKit version of Apple's Decimator Audio Unit
///
open class Decimator: Node, Toggleable {

    fileprivate let effectAU = AVAudioUnitEffect(
    audioComponentDescription:
    AudioComponentDescription(appleEffect: kAudioUnitSubType_Distortion))

    let input: Node
    override public var connections: [Node] { [input] }

    /// Specification details for decimation
    public static let decimationDef = NodeParameterDef(
        identifier: "decimation",
        name: "Decimation",
        address: 7,
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent,
        flags: .default)

    /// Decimation (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(decimationDef) public var decimation: AUValue

    /// Specification details for rounding
    public static let roundingDef = NodeParameterDef(
        identifier: "rounding",
        name: "Rounding",
        address: 8,
        defaultValue: 0,
        range: 0 ... 100,
        unit: .percent,
        flags: .default)

    /// Rounding (Percent) ranges from 0 to 100 (Default: 0)
    @Parameter(roundingDef) public var rounding: AUValue

    /// Specification details for finalMix
    public static let finalMixDef = NodeParameterDef(
        identifier: "finalMix",
        name: "Final Mix",
        address: 15,
        defaultValue: 50,
        range: 0 ... 100,
        unit: .percent,
        flags: .default)

    /// Final Mix (Percent) ranges from 0 to 100 (Default: 50)
    @Parameter(finalMixDef) public var finalMix: AUValue

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the decimator node
    ///
    /// - parameter input: Input node to process
    /// - parameter decimation: Decimation (Percent) ranges from 0 to 100 (Default: 50)
    /// - parameter rounding: Rounding (Percent) ranges from 0 to 100 (Default: 0)
    /// - parameter finalMix: Final Mix (Percent) ranges from 0 to 100 (Default: 50)
    ///
    public init(
        _ input: Node,
        decimation: AUValue = decimationDef.defaultValue,
        rounding: AUValue = roundingDef.defaultValue,
        finalMix: AUValue = finalMixDef.defaultValue) {
        self.input = input
        super.init(avAudioNode: effectAU)

        associateParams(with: effectAU)

        self.decimation = decimation
        self.rounding = rounding
        self.finalMix = finalMix
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func start() {
        effectAU.bypass = false
        isStarted = true
    }

    /// Function to stop or bypass the node, both are equivalent
    public func stop() {
        effectAU.bypass = true
        isStarted = false
    }
}
