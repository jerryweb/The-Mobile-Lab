//
//  Track.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This class holds the information for each indiviual track such as volume, pan and the sample loaded. The sample is automatically set the kick sample. 

#import "TrackModel.h"
@interface TrackModel()



@end

@implementation TrackModel

- (void)initTrack{
        self.sampleName = @"Bar_K";
        self.sampleFileType = @"wav";
        self.trackVolume = 0.5;     // This value ranges from 0 to 1
        self.trackPan = 0;          // This value ranges from -1 (full left) to 1 (full right)
        self.muted = NO;
}

@end
