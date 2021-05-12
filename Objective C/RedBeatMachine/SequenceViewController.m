//
//  SequenceViewController.m
//  RedBeatMachine
//
//  Created by LJ on 5/6/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This holds the set of steps that the user can use to create the drum pattern. There are 16 steps per track for a total of a 2 bar patten loop. The 

#import "SequenceViewController.h"
#import "TracksSingleton.h"
#import "SequencerModel.h"
#import "StepCollectionViewCell.h"

@interface SequenceViewController ()
@property (strong, nonatomic) TracksSingleton *tracksSingleton;
@property (strong, nonatomic) SequencerModel *sequencerModel;


// Labels to display the sample names of each track
@property (weak, nonatomic) IBOutlet UILabel *track0Label;
@property (weak, nonatomic) IBOutlet UILabel *track1Label;
@property (weak, nonatomic) IBOutlet UILabel *track2Label;
@property (weak, nonatomic) IBOutlet UILabel *track3Label;
@property (weak, nonatomic) IBOutlet UILabel *track4Label;
@property (weak, nonatomic) IBOutlet UILabel *track5Label;
@property (weak, nonatomic) IBOutlet UILabel *track6Label;
@property (weak, nonatomic) IBOutlet UILabel *track7Label;

// Mute buttons associated with each track
@property (weak, nonatomic) IBOutlet UIButton *muteButton0;
@property (weak, nonatomic) IBOutlet UIButton *muteButton1;
@property (weak, nonatomic) IBOutlet UIButton *muteButton2;
@property (weak, nonatomic) IBOutlet UIButton *muteButton3;
@property (weak, nonatomic) IBOutlet UIButton *mutebutton4;
@property (weak, nonatomic) IBOutlet UIButton *muteButton5;
@property (weak, nonatomic) IBOutlet UIButton *muteButton6;
@property (weak, nonatomic) IBOutlet UIButton *muteButton7;



@end

@implementation SequenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];
    // Do any additional setup after loading the view.
    
    [self updateTrackNames];
    [self setupMuteButtons];

}

- (void)viewWillAppear:(BOOL)animated {
    [self updateTrackNames];
    [self setupMuteButtons];
}

#pragma mark - refreshing view methods

//- (void)viewWillAppear:(BOOL)animated{
//    [self updateTrackNames];
//    [self setupMuteButtons];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) updateTrackNames {
    self.track0Label.text = [self.tracksSingleton returnTrackName:0];
    self.track1Label.text = [self.tracksSingleton returnTrackName:1];
    self.track2Label.text = [self.tracksSingleton returnTrackName:2];
    self.track3Label.text = [self.tracksSingleton returnTrackName:3];
    self.track4Label.text = [self.tracksSingleton returnTrackName:4];
    self.track5Label.text = [self.tracksSingleton returnTrackName:5];
    self.track6Label.text = [self.tracksSingleton returnTrackName:6];
    self.track7Label.text = [self.tracksSingleton returnTrackName:7];
}


#pragma mark - Set up the embedded collectionView for each of the mixer tracks

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 16;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StepCollectionCell" forIndexPath:indexPath];
    
    // Configure the cell
    [cell setupCell: [self.tracksSingleton returnTrack:indexPath.row] :indexPath.row :indexPath.section];
     
    
    return cell;
}

// Set the correct button images depending upon the state of the app
- (void) setupMuteButtons {
    
    if([self.tracksSingleton returnTrack:0].muted){
        [self.muteButton0  setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.muteButton0  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
    if([self.tracksSingleton returnTrack:1].muted){
        [self.muteButton1  setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.muteButton1  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
    if([self.tracksSingleton returnTrack:2].muted){
        [self.muteButton2  setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.muteButton2  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
    if([self.tracksSingleton returnTrack:3].muted){
        [self.muteButton3  setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.muteButton3  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
    if([self.tracksSingleton returnTrack:4].muted){
        [self.mutebutton4  setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.mutebutton4  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
    if([self.tracksSingleton returnTrack:5].muted){
        [self.muteButton5  setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.muteButton5  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
    if([self.tracksSingleton returnTrack:6].muted){
        [self.muteButton6  setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.muteButton6  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
    if([self.tracksSingleton returnTrack:7].muted){
        [self.muteButton7   setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    else{
        [self.muteButton7  setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    }
    
}


#pragma mark - MuteButton event triggered

- (IBAction)muteButton0Pressed:(id)sender {
    if([[self.tracksSingleton returnTrack:0] muted]){
        
        [self.muteButton0 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton0 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:0 :![[self.tracksSingleton returnTrack:0] muted]];
    
}


- (IBAction)muteButton1Pressed:(id)sender {
    
    if([[self.tracksSingleton returnTrack:1] muted]){
        
        [self.muteButton1 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton1 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:1 :![[self.tracksSingleton returnTrack:1] muted]];
}


- (IBAction)muteButton2Pressed:(id)sender {
    if([[self.tracksSingleton returnTrack:2] muted]){
        
        [self.muteButton2 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton2 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:2 :![[self.tracksSingleton returnTrack:2] muted]];
}


- (IBAction)muteButton3Pressed:(id)sender {
    if([[self.tracksSingleton returnTrack:3] muted]){
        
        [self.muteButton3 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton3 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:3 :![[self.tracksSingleton returnTrack:3] muted]];
}


- (IBAction)muteButton4Pressed:(id)sender {
    if([[self.tracksSingleton returnTrack:4] muted]){
        
        [self.mutebutton4 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.mutebutton4 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:4 :![[self.tracksSingleton returnTrack:4] muted]];
}


- (IBAction)muteButton5Pressed:(id)sender {
    if([[self.tracksSingleton returnTrack:5] muted]){
        
        [self.muteButton5 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton5 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:5 :![[self.tracksSingleton returnTrack:5] muted]];
}


- (IBAction)muteButton6Pressed:(id)sender {
    if([[self.tracksSingleton returnTrack:6] muted]){
        
        [self.muteButton6 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton6 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:6 :![[self.tracksSingleton returnTrack:6] muted]];
}


- (IBAction)muteButton7Pressed:(id)sender {

    if([[self.tracksSingleton returnTrack:7] muted]){
        
        [self.muteButton7 setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.muteButton7 setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
    }
    
    // Toggle mute for the track
    [self.tracksSingleton toggleTrackMute:7 :![[self.tracksSingleton returnTrack:7] muted]];
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
