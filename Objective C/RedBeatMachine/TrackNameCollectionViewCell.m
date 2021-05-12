//
//  TrackNameCollectionViewCell.m
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This class formats the collection view cell which holds the track names and track quick access mute buttons

#import "TrackNameCollectionViewCell.h"
#import "TracksSingleton.h"
#import "SequencerModel.h"


@interface TrackNameCollectionViewCell()
@property (strong, nonatomic) TracksSingleton *tracksSingleton;
@property (strong, nonatomic) SequencerModel *sequencerModel;
@property (nonatomic) NSInteger mixerTrackNumber;
@property (weak, nonatomic) IBOutlet UILabel *sampleNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *muteButton;

@end


@implementation TrackNameCollectionViewCell

- (void) setupTrackNameCell: (TrackModel *) track : (NSInteger) trackNumber{
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];
    self.mixerTrackNumber = trackNumber;

    self.sampleNameLabel.text = track.sampleName;
    
    if([[self.tracksSingleton returnTrack:self.mixerTrackNumber] muted]){
        
        [self.muteButton setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)toggleMuteButton:(id)sender {
    
    // Toggle the mute button image
    if([[self.tracksSingleton returnTrack:self.mixerTrackNumber] muted]){
        
        [self.muteButton setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }

    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:self.mixerTrackNumber :![[self.tracksSingleton returnTrack:self.mixerTrackNumber] muted]];
}




@end
