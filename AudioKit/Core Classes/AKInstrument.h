//
//  AKInstrument.h
//  AudioKit
//
//  Created by Aurelius Prochazka on 4/11/12.
//  Copyright (c) 2012 Aurelius Prochazka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKOrchestra.h"
#import "AKParameter+Operation.h"
#import "AKAudio.h"
#import "AKStereoAudio.h"
#import "AKPhrase.h"
#import "AKNote.h"
#import "AKNoteProperty.h"
#import "AKInstrumentProperty.h"
@class AKEvent;

/** Manages functions that most AK instruments need to have.*/

@interface AKInstrument : NSObject 

// -----------------------------------------------------------------------------
#  pragma mark - Initialization
// -----------------------------------------------------------------------------

/// Instantiates a new instrument
+ (instancetype)instrument;

/// Instantiates a new instrument at a given instrument number
/// @param instrumentNumber Unique number to assign this instrument, useful when overwriting an instrument
+ (instancetype)instrumentWithNumber:(int)instrumentNumber;

/// Instantiates a new instrument at a given instrument number
/// @param instrumentNumber Unique number to assign this instrument, useful when overwriting an instrument
- (instancetype)initWithNumber:(int)instrumentNumber;

/// Unique instrument number
- (int)instrumentNumber;

/// A string uniquely defined by the instrument class name and a unique integer.
- (NSString *)uniqueName;

/// Allows the unique identifying integer to be reset so that the numbers don't increment indefinitely.
+ (void)resetID;

// -----------------------------------------------------------------------------
#  pragma mark - Properties
// -----------------------------------------------------------------------------

/// Array of instrument properties available for the instrument.
@property NSMutableArray *properties;


/// Array of note properties available to events.
@property NSMutableArray *noteProperties;

/// After an AKProperty is created, it must be added to the instrument.
/// @param newProperty New property to add to the instrument.
- (void) addProperty:(AKInstrumentProperty *)newProperty;

/// After an AKNoteProperty is created, it must be added to the instrument.
/// @param newNoteProperty New note property instrument needs to be aware of.
- (void)addNoteProperty:(AKNoteProperty *)newNoteProperty;


// -----------------------------------------------------------------------------
#  pragma mark - Function Tables
// -----------------------------------------------------------------------------

/// Adds the function table to the Orchestra, so it is only processed once.
/// @param newFunctionTable New function table to add to the orchestra.
- (void)addFunctionTable:(AKFunctionTable *)newFunctionTable;

/// Adds the function table to the AKInstrument dynamically, processed for each note.
/// @param newFunctionTable New function table to add to the instrument.
- (void)addDynamicFunctionTable:(AKFunctionTable *)newFunctionTable;

// -----------------------------------------------------------------------------
#  pragma mark - Operations
// -----------------------------------------------------------------------------

/// All UDOs that are required by the instrument are stored here and declared before the instrument block.
@property NSMutableSet *userDefinedOperations;

/// Globally accessible parameters used for cross-instrument communication
@property NSMutableSet *globalParameters;

/// Adds the operation to the AKInstrument.
/// @param newOperation New operation to add to the instrument.
- (void)connect:(AKParameter *)newOperation;

/// Sets a parameter to be the audio output of the AKInstrument.  Equivalent to declaring and connect AKAudioOutput.
/// @param audio Operation output that you want to be played.
- (void)setAudioOutput:(AKParameter *)audio;

/// Sets a parameter to be the audio output of the AKInstrument.  Equivalent to declaring and connect AKAudioOutput.
/// @param audio Operation output that you want to be played.
- (void)setAudioOutputWithLeftAudio:(AKParameter *)leftInput rightAudio:(AKParameter *)rightInput;

/// Sets a parameter to be the audio output of the AKInstrument.  Equivalent to declaring and connect AKAudioOutput.
/// @param stereo Stereo Operation output that you want to be played.
- (void)setStereoAudioOutput:(AKStereoAudio *)stereo;

/// Adds any string to the output file, useful for testing and commenting.
/// @param newString New string to add to the instrument definition.
- (void)addString:(NSString *)newString;

/// Appending a value to an output, usually a globally accessibly audio stream
/// @param output Parameter being set.
/// @param input  Parameter being read.
- (void)appendOutput:(AKParameter *)output withInput:(AKParameter *)input;

/// Deprecated function, please use appendOutput:withInput:
/// @param output Parameter being set.
/// @param input  Parameter being read.
- (void)assignOutput:(AKParameter *)output to:(AKParameter *)input;

/// Explicitly set the output of one paramter to another, useful for tracking
/// @param parameter Output or overwritten parameter
/// @param input     Input parameter
- (void)setParameter:(AKParameter *)parameter to:(AKParameter *)input;

/// Shortcut for setting a parameter's value to zero.
/// @param parameterToReset Parameter whose value will be reset to zero.
- (void)resetParameter:(AKParameter *)parameterToReset;

/// Log parameter values at a given frequency with a message.
/// @param message   Message to print first. Usually something like "myParameter = "
/// @param parameter The parameter to log the float value of
/// @param timeInterval Time in seconds between printouts.
- (void)enableParameterLog:(NSString *)message
                 parameter:(AKParameter *)parameter
              timeInterval:(float)timeInterval;

// -----------------------------------------------------------------------------
#  pragma mark - Csound Implementation
// -----------------------------------------------------------------------------

// The textual respresentation of the instrument in CSD form.
- (NSString *)stringForCSD;

// The CSD line that deactivates all notes created by the instrument
- (NSString *)stopStringForCSD;

/// Play an instrument that contains no note properties ie. uses a generic
/// AKNote to begin playback for a specific amount of time.
/// @param playDuration Length of time in seconds to play the instrument.
- (void)playForDuration:(float)playDuration;

/// For instruments that do not create note instances, play the instrument with infinite duration.
- (void)play;

/// Play the given note
/// @param note The note that will be played.
- (void)playNote:(AKNote *)note;

/// Play the given note after a delay
/// @param note The note that will be played.
/// @param delay The amount of time to wait until playing the note
- (void)playNote:(AKNote *)note afterDelay:(float)delay;

/// Stop the given note
/// @param note The note that will be stopped.
- (void)stopNote:(AKNote *)note;

/// Stop the given note after a delay
/// @param note The note that will be stopped.
/// @param delay The amount of time to wait until stopping the note
- (void)stopNote:(AKNote *)note afterDelay:(float)delay;

/// Play the given note phrase
/// @param phrase The note phrase that will be played.
- (void)playPhrase:(AKPhrase *)phrase;

/// Repeat a note phrase
/// @param phrase The note phrase that will be played.
- (void)repeatPhrase:(AKPhrase *)phrase;

/// Repeat a note phrase periodically
/// @param phrase The note phrase that will be played.
/// @param duration The period between playbacks
- (void)repeatPhrase:(AKPhrase *)phrase duration:(float)duration;

/// Stop all notes created by the instrument
- (void)stop;

@end
