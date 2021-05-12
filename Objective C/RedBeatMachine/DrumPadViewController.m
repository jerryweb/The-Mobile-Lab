//
//  DrumPadViewController.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "DrumPadViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "TracksSingleton.h"
#import "SequencerModel.h"


@interface DrumPadViewController ()
@property (strong, nonatomic) TracksSingleton *tracksSingleton;
@property (strong, nonatomic) SequencerModel *sequencerModel;

@property (weak, nonatomic) IBOutlet UISlider *masterVolumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *masterVolumeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *metronomeButton;
@property (weak, nonatomic) IBOutlet UIStepper *bpmStepper;
@property (weak, nonatomic) IBOutlet UITextView *bmpTextView;

@end

@implementation DrumPadViewController


#pragma mark - refreshing view methods
- (void)viewWillAppear:(BOOL)animated {
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];
    [self setBpmTextView];
    [self.bpmStepper setValue:[self.sequencerModel bpm]];
    
    
    
    [self.masterVolumeSlider setValue:[self.tracksSingleton masterVolume]];
    [self modifyMasterVolume:[self.tracksSingleton masterVolume]];

    [self setupButtons];
    
    [self updatePadNames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// update the names of each of the button pads to match the assigned sound sample
- (void) updatePadNames{
    [self.pad0 setTitle:[self.tracksSingleton returnTrackName:0] forState:UIControlStateNormal];
    [self.pad1 setTitle:[self.tracksSingleton returnTrackName:1] forState:UIControlStateNormal];
    [self.pad2 setTitle:[self.tracksSingleton returnTrackName:2] forState:UIControlStateNormal];
    [self.pad3 setTitle:[self.tracksSingleton returnTrackName:3] forState:UIControlStateNormal];
    [self.pad4 setTitle:[self.tracksSingleton returnTrackName:4] forState:UIControlStateNormal];
    [self.pad5 setTitle:[self.tracksSingleton returnTrackName:5] forState:UIControlStateNormal];
    [self.pad6 setTitle:[self.tracksSingleton returnTrackName:6] forState:UIControlStateNormal];
    [self.pad7 setTitle:[self.tracksSingleton returnTrackName:7] forState:UIControlStateNormal];

}



#pragma mark - Playback settings: This is settings such as volume and bpm modifier events are handled

- (void) modifyMasterVolume: (float) volume{
    NSString *percentSign = @"%";
    self.masterVolumeLabel.text = [NSString stringWithFormat:@"%.00f%@", volume*100, percentSign];
}
- (IBAction)sliderChangeMasterVolume:(id)sender {
    
    [self modifyMasterVolume: self.masterVolumeSlider.value];
    [self.tracksSingleton setMasterVolume:self.masterVolumeSlider.value];

}


- (IBAction)stepBpm:(id)sender {
    [self.sequencerModel setBpm:self.bpmStepper.value];
    [self setBpmTextView];
}

- (void) setBpmTextView{
    self.bmpTextView.text = [NSString stringWithFormat: @"%ld", (long)self.sequencerModel.bpm];
}



#pragma mark - transport button events these are the actions associated to the transport buttons (play, pause, stop, and record)

- (IBAction)togglePlayButton:(id)sender {
    if(!self.sequencerModel.play){
        [self.playButton setImage:[UIImage imageNamed:@"play_active.png"] forState:UIControlStateNormal];
        [self.sequencerModel startPlayback];
        self.sequencerModel.play = YES;
    }
    else {
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [self stopPlaying];
    }
}


- (IBAction)toggleRecordButton:(id)sender {
    if(!self.sequencerModel.record){
        [self.recordButton setImage:[UIImage imageNamed:@"recordActive.png"] forState:UIControlStateNormal];
        self.sequencerModel.record = YES;
    }
    else {
        [self.recordButton setImage:[UIImage imageNamed:@"record.png"] forState:UIControlStateNormal];
        self.sequencerModel.record = NO;
    }
}

- (IBAction)toggleMetronomeButton:(id)sender {
    
    if(!self.sequencerModel.metronome){
        [self.metronomeButton setImage:[UIImage imageNamed:@"metronome_active.png"] forState:UIControlStateNormal];
        [self.sequencerModel setMetronome:YES];
    }
    else {
        [self.metronomeButton setImage:[UIImage imageNamed:@"metronome.png"] forState:UIControlStateNormal];
        [self.sequencerModel setMetronome:NO];
    }
}

- (IBAction)pauseButtonPressed:(id)sender {
    [self stopPlaying];
}

- (IBAction)stopButtonPressed:(id)sender {
    [self stopPlaying];
}

- (void) stopPlaying{
    if(self.sequencerModel.play){
        self.sequencerModel.play = NO;
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [self.sequencerModel stopPlayback];
    }
}



// Set the correct button images depending upon the state of the app
- (void) setupButtons {
    
    // play button
    if(!self.sequencerModel.play){
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    else{
        [self.playButton setImage:[UIImage imageNamed:@"play_active.png"] forState:UIControlStateNormal];
    }
    
    // record button
    if(!self.sequencerModel.record){
        [self.recordButton setImage:[UIImage imageNamed:@"record.png"] forState:UIControlStateNormal];
    }
    else{
        [self.recordButton setImage:[UIImage imageNamed:@"recordActive.png"] forState:UIControlStateNormal];
    }
    
    // metronome button
    if(!self.sequencerModel.metronome){
        [self.metronomeButton setImage:[UIImage imageNamed:@"metronome.png"] forState:UIControlStateNormal];
    }
    else{
        [self.metronomeButton setImage:[UIImage imageNamed:@"metronome_active.png"] forState:UIControlStateNormal];
    }
    
}

#pragma mark - Triggering pad to play sounds

// When touched, the pad will play the sample attached to the respective track signleton. Example, pad 0 will play the sound set to track 0



- (IBAction)triggerPad0:(id)sender {
    [self.tracksSingleton playTrackSample:0];
    [self.sequencerModel recordHit:0];
}

- (IBAction)triggerPad1:(id)sender {
    [self.tracksSingleton playTrackSample:1];
    [self.sequencerModel recordHit:1];

}

- (IBAction)triggerPad2:(id)sender {
    [self.tracksSingleton playTrackSample:2];
    [self.sequencerModel recordHit:2];

}

- (IBAction)triggerPad3:(id)sender {
    [self.tracksSingleton playTrackSample:3];
    [self.sequencerModel recordHit:3];

}

- (IBAction)triggerPad4:(id)sender {
    [self.tracksSingleton playTrackSample:4];
    [self.sequencerModel recordHit:4];
}

- (IBAction)triggerPad5:(id)sender {
    [self.tracksSingleton playTrackSample:5];
    [self.sequencerModel recordHit:5];
}

- (IBAction)triggerPad6:(id)sender {
    [self.tracksSingleton playTrackSample:6];
    [self.sequencerModel recordHit:6];

}

- (IBAction)triggerPad7:(id)sender {
    [self.tracksSingleton playTrackSample:7];
    [self.sequencerModel recordHit:7];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
