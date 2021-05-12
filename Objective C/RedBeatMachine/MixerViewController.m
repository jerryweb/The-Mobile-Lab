//
//  MixerViewController.m
//  RedBeatMachine
//
//  Created by LJ on 5/3/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "MixerViewController.h"
#import "TracksSingleton.h"
#import "SequencerModel.h"
#import "MixerTrackCollectionViewCell.h"


@interface MixerViewController ()
@property (strong, nonatomic) TracksSingleton *tracksSingleton;
@property (strong, nonatomic) SequencerModel *sequencerModel;

@property (weak, nonatomic) IBOutlet UISlider *MasterVolumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *masterVolumeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end

@implementation MixerViewController


- (void) viewDidLoad {
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];
    
    // Rotate the slider to have a verticle orientation
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI_2);
    self.MasterVolumeSlider.transform = trans;
    
    // Update slider value and master volume label to the appropriate value set in the track singleton
    [self.MasterVolumeSlider setValue:[self.tracksSingleton masterVolume]];
    [self modifyMasterVolume: self.MasterVolumeSlider.value];
    
    // Update the play button to either active or ready image state depending on if the user has pressed play in a different UIView
    if(!self.sequencerModel.play){
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
    }
    else{
        [self.playButton setImage:[UIImage imageNamed:@"play_active.png"] forState:UIControlStateNormal];
        
    }

}


- (void)viewWillAppear:(BOOL)animated {
    // Do any additional setup after loading the view.
        
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];
    
    // Rotate the slider to have a verticle orientation
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI_2);
    self.MasterVolumeSlider.transform = trans;
    
    // Update slider value and master volume label to the appropriate value set in the track singleton
    [self.MasterVolumeSlider setValue:[self.tracksSingleton masterVolume]];
    [self modifyMasterVolume: self.MasterVolumeSlider.value];
    
    // Update the play button to either active or ready image state depending on if the user has pressed play in a different UIView
    if(!self.sequencerModel.play){
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
    }
    else{
        [self.playButton setImage:[UIImage imageNamed:@"play_active.png"] forState:UIControlStateNormal];
        
    }
    
    [mixerTracks reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Set up the embedded collectionView for each of the mixer tracks

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MixerTrackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TrackCell" forIndexPath:indexPath];
    
    // Configure the cell
    [cell setupCell:[self.tracksSingleton returnTrack:indexPath.row] :indexPath.row];
    return cell;
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

- (IBAction)sliderChangedMasterVolume:(id)sender {
    [self modifyMasterVolume: self.MasterVolumeSlider.value];
    [self.tracksSingleton setMasterVolume:self.MasterVolumeSlider.value];

}


- (void) modifyMasterVolume: (float) volume{
    NSString *percentSign = @"%";
    self.masterVolumeLabel.text = [NSString stringWithFormat:@"%.00f%@", volume*100, percentSign];
}

- (void) setMasterVolume: (float) volume {
    self.MasterVolumeSlider.value = volume/100;
    [self.tracksSingleton setMasterVolume:volume];
    [self modifyMasterVolume: self.MasterVolumeSlider.value];
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
