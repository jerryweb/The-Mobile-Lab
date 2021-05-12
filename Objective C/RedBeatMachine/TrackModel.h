//
//  Track.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackModel : NSObject
@property (nonatomic) NSString *sampleName;      // Name of the sample audio file
@property (nonatomic) NSString *sampleFileType;  // Type of the sample audio file

@property (nonatomic) float trackVolume;
@property (nonatomic) float trackPan;
@property (nonatomic) BOOL muted;

// public methods
- (void) initTrack;
@end
