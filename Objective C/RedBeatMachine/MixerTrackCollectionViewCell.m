//
//  MixerTrackCollectionViewCell.m
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This class formats the collection veiw cell which holds the mixer track controls. There should be 8 of these, one for each track. Indiviual mute, Volume and Pan control events are handled here.

#import "MixerTrackCollectionViewCell.h"
#import "TracksSingleton.h"

@interface MixerTrackCollectionViewCell()
@property (strong, nonatomic) TracksSingleton *tracksSingleton;
//@property (strong, nonatomic) SequencerModel *sequencerModel;

@property (weak, nonatomic) IBOutlet UILabel *sampleNameLabel;
@property (weak, nonatomic) IBOutlet UISlider *panSlider;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UIButton *muteButton;
@property (strong, nonatomic) NSMutableArray * trackLabelArray;
// Identifies which track the audio controls correspond to e.g. track 0. Should not be changed after set for the first time
@property (nonatomic) NSInteger mixerTrackNumber;



@end

@implementation MixerTrackCollectionViewCell

// Similar to an init method, this builds and formats the cell, setting all of the outlet values and creating the trackSingleton.
- (void) setupCell: (TrackModel *) track : (NSInteger) trackNumber{
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.mixerTrackNumber = trackNumber;
    
    // trasform the sliders to verticle orientation
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI_2);
    self.panSlider.transform = trans;
    self.volumeSlider.transform = trans;
    
    self.sampleNameLabel.text = track.sampleName;
    self.panSlider.value = track.trackPan;
    self.volumeSlider.value = track.trackVolume;
    
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



// This sends a command to the trackSinglton to change this mixerTrack's corresponding audio track's volume
- (IBAction)modifyTrackVolume:(id)sender {
    NSString *percentSign = @"%";
    self.volumeLabel.text = [NSString stringWithFormat:@"%.00f%@", self. volumeSlider.value*100, percentSign];  // updated the volume label to notify the user the current volume level
    
    [self.tracksSingleton modifyTrackVolume:self.mixerTrackNumber :self.volumeSlider.value];
}


// This sends a command to the trackSinglton to change this mixerTrack's corresponding audio track's pan
- (IBAction)modifyTrackPan:(id)sender {
    [self.tracksSingleton modifyTrackPan:self.mixerTrackNumber :self.panSlider.value];
}

@end
