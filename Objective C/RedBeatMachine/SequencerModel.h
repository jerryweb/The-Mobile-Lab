//
//  SequencerModel.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SequencerModel : NSObject

@property (nonatomic) NSInteger bpm;    // beats per minute 
@property (nonatomic) BOOL play;        // play drum sequence
@property (nonatomic) BOOL record;      // when true, the using input of the drum pads will be recorded
@property (nonatomic) BOOL metronome;        // play metronome
// public methods
@property (nonatomic)  NSMutableArray *steps2DArray;

+ (instancetype) sharedModel;
- (void) startPlayback;
- (void) stopPlayback;
- (void) recordHit: (NSInteger) index;

@end
