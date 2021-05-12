//
//  TracksSingleton.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackModel.h"

// constants
static NSString * const kSampleNameKey = @"sampleName";
static NSString * const kSampleFileTypeKey = @"fileType";


@interface TracksSingleton : NSObject
@property (nonatomic) NSInteger soundDatabaseSegementedTrackValue;  // This keeps track of which track's sample the user wants to change when accessing the database

// public methods
+ (instancetype) sharedModel;
- (void) playTrackSample: (NSInteger) trackNumber;
//- (void) setMasterVolume: (float) volume;
- (NSString *) returnTrackName: (NSUInteger) index;     // Returns the name of the sample for the given track

- (TrackModel *) returnTrack: (NSUInteger) index;        // Returns the speicified track

- (void) changeTrackSample: (NSString *) newSampleName : (NSUInteger) index : (NSString *) newFileType;


- (void) modifyTrackVolume: (NSInteger) trackNumber : (float) volume;   // Public method called by the mixer to change individual track volumes 

- (void) modifyTrackPan: (NSInteger) trackNumber : (float) pan;   // Public method called by the mixer to change individual track pan

- (void) toggleTrackMute: (NSInteger) trackNumer : (BOOL) mute;  // This toggles the track mute: if the track is muted, it will unmute and vice-versa

- (NSDictionary *) returnSampleFromListOfSamples: (NSUInteger) index;
- (NSInteger) returnSizeOfSampleList;


@property (nonatomic) float masterVolume;

@end
