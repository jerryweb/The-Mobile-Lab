//
//  TracksSingleton.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This is the signleton that will hold all of the tracks and sample data Along with the assign and play methods. This class also holds the reference to the AudioToolBox and is where the sound is triggered and played. There are 8 seperate Audio services, one for each track, used to play the samples assinged to each of the tracks.

#import "TracksSingleton.h"
#import "TrackModel.h"
#import "SequencerModel.h"
//#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
//#import <Firebase/Firebase.h>


@interface TracksSingleton(){
    
    AVAudioPlayer *track0Player;
    AVAudioPlayer *track1Player;
    AVAudioPlayer *track2Player;
    AVAudioPlayer *track3Player;
    AVAudioPlayer *track4Player;
    AVAudioPlayer *track5Player;
    AVAudioPlayer *track6Player;
    AVAudioPlayer *track7Player;
    AVAudioPlayer *metronomePlayer;
    
    AVAudioEngine *avMixer;
    AVAudioNode *trackNode0;
    AVAudioUnitTimePitch *trackPitch0;

}

@property (strong, nonatomic) SequencerModel *sequencerModel;
@property (strong, nonatomic) NSMutableArray *tracks;
@property (strong, nonatomic) NSMutableArray *listOfSamples;        // Array of dictionaries which hold the sample name and file type

// This holds the ID for each track. These can be used for any sample as long as the file path to the sample is used
@property (readonly) SystemSoundID track0Id;
@property (readonly) SystemSoundID track1Id;
@property (readonly) SystemSoundID track2Id;
@property (readonly) SystemSoundID track3Id;
@property (readonly) SystemSoundID track4Id;
@property (readonly) SystemSoundID track5Id;
@property (readonly) SystemSoundID track6Id;
@property (readonly) SystemSoundID track7Id;

@end

@implementation TracksSingleton

+(instancetype) sharedModel{
    static TracksSingleton
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
//        self.sequencerModel = [SequencerModel sharedModel];
        
        [self generateListOfSounds];
        
        // Paths to all of the sound files and connections to the URLs for the sound file IDs
        [self generateTracks];
        self.masterVolume = (float)0.5;
//        [self interactWithFirebase];
    }
    return self;

}

- (void) generateAVAudioMixer {
    
    trackNode0.
    
    
}


// Create an array of dictionary objects which hold the sample name and file type such as wav or mp3
- (void) generateListOfSounds{
    NSDictionary *sound_0 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Bar_K", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hi_Tom2", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Cap_Snr", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hi_Shk3", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tmb_3", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wan_Ohh", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Bngo_3", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Perfect 808", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"2uicksilver 808 single", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lex Rim(2)", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"CB_Hat", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_11 = [[NSDictionary alloc] initWithObjectsAndKeys:@"CB_Kick", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];
    NSDictionary *sound_12 = [[NSDictionary alloc] initWithObjectsAndKeys:@"vybe809Kick", kSampleNameKey, @"wav", kSampleFileTypeKey,nil];


    
    _listOfSamples = [[NSMutableArray alloc] initWithObjects:sound_0, sound_1, sound_2, sound_3, sound_4, sound_5, sound_6, sound_7, sound_8, sound_9, sound_10, sound_11, sound_12,nil];
}

// Create 8 track objects and add them to an array
- (void) generateTracks{
    _tracks = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 8; i++)
    {
        TrackModel *track = [TrackModel new];
        [track initTrack];
        [track setSampleName:self.listOfSamples[i][kSampleNameKey]];
        [track setSampleFileType:self.listOfSamples[i][kSampleFileTypeKey]];

        [_tracks addObject:track];

    }
}

- (NSString *) returnTrackName: (NSUInteger) index{
    if(index >= 0 && index < self.tracks.count){
        return [self.tracks[index] sampleName];
    }
    else return NULL;
}

- (TrackModel *) returnTrack: (NSUInteger) index{
    if(index >= 0 && index < self.tracks.count){
        return self.tracks[index];
    }
    else return NULL;
}

- (NSDictionary *) returnSampleFromListOfSamples: (NSUInteger) index{

    if(index >= 0 && index < self.listOfSamples.count){
        return self.listOfSamples[index];
    }
    else return NULL;
}

- (NSInteger) returnSizeOfSampleList{
    return self.listOfSamples.count;
}

// This changes the sound of the given track to the given sound in the user sound database
- (void) changeTrackSample: (NSString *) newSampleName : (NSUInteger) index : (NSString *) newFileType{
    if(index >= 0 && index < self.listOfSamples.count){

        [self.tracks[index] setSampleName:newSampleName];
        [self.tracks[index] setSampleFileType:newFileType];
    }
}




#pragma mark - Public access methods to modify volume, pan and mute settings for each track

- (void) modifyTrackPan: (NSInteger) trackNumber : (float) pan{
    [self.tracks[trackNumber] setTrackPan:pan];

}

- (void) modifyTrackVolume: (NSInteger) trackNumber : (float) volume{
    [self.tracks[trackNumber] setTrackVolume:volume];
}

- (void) toggleTrackMute: (NSInteger) trackNumer : (BOOL) mute{
    [self.tracks[trackNumer] setMuted:mute];
}

#pragma mark - play tracks

// This method plays the samples according the track that is called
- (void) playTrackSample: (NSInteger) trackNumber{
    
    // Connect the sampleName and file type with the file Path and URL
    NSString *trackFilePath;
    NSURL *trackURL;
    if(trackNumber == 8){
        trackFilePath = [[NSBundle mainBundle]pathForResource:@"LEX Rim(2)" ofType:@"wav"];
        trackURL = [NSURL fileURLWithPath:trackFilePath];
    }
    else{
        trackFilePath = [[NSBundle mainBundle]pathForResource:[self.tracks[trackNumber] sampleName] ofType:[self.tracks[trackNumber] sampleFileType]];
        trackURL = [NSURL fileURLWithPath:trackFilePath];
    }
    
    
    switch (trackNumber) {
        case 0:
            
            
            
            
            
            // Remake the AVAudioPlayer; this prevents sluggish response
            track0Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            [track0Player stop];
            // set volume output of track
            
            [track0Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track0Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track0Player play];
            }
            break;
            
        case 1:
            // Remake the AVAudioPlayer; this prevents sluggish response
            track1Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [track1Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track1Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track1Player play];
            }
            break;

        case 2:
            // Remake the AVAudioPlayer; this prevents sluggish response
            track2Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [track2Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track2Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track2Player play];
            }
            break;

        case 3:
            // Remake the AVAudioPlayer; this prevents sluggish response
            track3Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [track3Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track3Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track3Player play];
            }
            break;
        case 4:
            // Remake the AVAudioPlayer; this prevents sluggish response
            track4Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [track4Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track4Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track4Player play];
            }
            break;

        case 5:
            // Remake the AVAudioPlayer; this prevents sluggish response
            track5Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [track5Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track5Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track5Player play];
            }
            break;

        case 6:
            // Remake the AVAudioPlayer; this prevents sluggish response
            track6Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [track6Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track6Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track6Player play];
            }
            break;

        case 7:
            // Remake the AVAudioPlayer; this prevents sluggish response
            track7Player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [track7Player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
            
            // set pan of track output
            [track7Player setPan:[self.tracks[trackNumber] trackPan]];
            
            // play sample if the track is not muted
            if(![self.tracks[trackNumber] muted]){
                [track7Player play];
            }
            break;
            
        case 8:
            // Remake the AVAudioPlayer; this prevents sluggish response
            metronomePlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
            
            // set volume output of track
            
            [metronomePlayer setVolume:(self.masterVolume)];
            
            // play sample if the track is not muted
            [metronomePlayer play];
            
            break;
        default:
            break;
    }


}




//- (void) interactWithFirebase{
//    // Create a reference to a Firebase database URL
//    Firebase *rebBeatMachineRootReference = [[Firebase alloc] initWithUrl:@"https://redbeatmachine.firebaseio.com"];
//    
//    [rebBeatMachineRootReference observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
//    }];
//}
@end

