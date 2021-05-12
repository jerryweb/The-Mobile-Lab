//
//  SequencerModel.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This class holds the thread that powers the midi sequencer that plays the given drum pattern. It holds references to the Track singleton and connects the sequencer view controller to the tracks.

#import "SequencerModel.h"
#import "TracksSingleton.h"
#import <dispatch/dispatch.h>

@interface SequencerModel()

@property (nonatomic) NSInteger numberOfSteps;      // This should a be a multiple of 16 * the total number of tracks e.g. 8 * 16 = 128
@property (strong, nonatomic) TracksSingleton *tracksSingleton;

@property (nonatomic) NSThread *sequencerThread;    // This is used to play the pattern back at a given bpm. The thread will run in the background and trigger any samples that are TRUE during that beat time step. The thread is initiated by the play button and stopped when the pause or stop button is pressed.
@property (nonatomic) NSInteger currentStep;

@end
@implementation SequencerModel
dispatch_semaphore_t bpmSemaphore;      // This keeps the tempo of the pattern playing at the set bpm
dispatch_semaphore_t playSemaphore;     // This allows the thread running the sequencer to stop and start when the user triggers the tansport buttons

+(instancetype) sharedModel{
    static SequencerModel
    *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // Create a 2D array of the boolean values for each step in the step sequence. Set all the default values to false to prevent any samples from playing.
        _steps2DArray = [[NSMutableArray alloc] initWithCapacity:16];
        for(int i = 0; i < 16; i++){
            NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:8];
            for (int i = 0; i < 8; i++){
                [row addObject:@"NO"];
            }
            [self.steps2DArray addObject:row];
        }
        
        [self.sequencerThread start];

        self.play = NO;
        self.record = NO;
        self.metronome = NO;
        self.bpm = 90;
        self.tracksSingleton = [TracksSingleton sharedModel];
        

        bpmSemaphore = dispatch_semaphore_create(1);            // Allow only one semaphore so that it acts as a lock
        
        dispatch_semaphore_wait(bpmSemaphore, DISPATCH_TIME_FOREVER);   // Wait for a signal until the app closes
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^(void) {[self playSequence]; });

    }
    return self;
}




#pragma mark - play the pattern using the thread and semaphores

- (void) playSequence {

        for (int i = 0; i < 16; i++) {
            self.currentStep = i;
            dispatch_semaphore_wait(bpmSemaphore, DISPATCH_TIME_FOREVER);
            
            if(self.metronome && i % 4 == 0){
                [self.tracksSingleton playTrackSample:8];
            }
            
            NSMutableArray *row = self.steps2DArray[i];

            if([row[0]  boolValue]){
                [self.tracksSingleton playTrackSample:0];
            }
            if([row[1] boolValue]){
//                NSLog(@"track 1 of i = %d", i);

                [self.tracksSingleton playTrackSample:1];
            }
            if([row[2] boolValue]){
//                NSLog(@"track 2 of i = %d", i);

                [self.tracksSingleton playTrackSample:2];
            }
            if([row[3] boolValue]){
//                NSLog(@"track 3 of i = %d", i);

                [self.tracksSingleton playTrackSample:3];
            }
            if([row[4] boolValue]){
                
                [self.tracksSingleton playTrackSample:4];
            }
            if([row[5] boolValue]){
                [self.tracksSingleton playTrackSample:5];
            }
            if([row[6] boolValue]){
                [self.tracksSingleton playTrackSample:6];
            }
            if([row[7] boolValue]){
                [self.tracksSingleton playTrackSample:7];
            }
                   
            dispatch_semaphore_signal(bpmSemaphore);
            usleep(60000000/(self.bpm *4));
            if(i == 15){
                i = -1;
            }
        }
}

- (void) recordHit: (NSInteger) index{
    if(self.record){
        NSMutableArray *row = self.steps2DArray[self.currentStep];
        row[index] = @"YES";
        [self.steps2DArray replaceObjectAtIndex:self.currentStep withObject:row];
    }
}



- (void) startPlayback{
    dispatch_semaphore_signal(bpmSemaphore);
}

- (void) stopPlayback
{
    dispatch_semaphore_wait(bpmSemaphore, DISPATCH_TIME_FOREVER);
}

@end
