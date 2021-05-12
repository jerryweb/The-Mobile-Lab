//
//  SampleTableViewCell.m
//  RedBeatMachine
//
//  Created by LJ on 5/5/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "SampleTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "TracksSingleton.h"

@interface SampleTableViewCell(){
    AVAudioPlayer *player;
}
@property (strong, nonatomic) TracksSingleton *tracksSingleton;

@property (weak, nonatomic) IBOutlet UILabel *sampleNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *preivewSampleButton;

@end

@implementation SampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) formatCell{
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sampleNameLabel.text = self.sampleName;
    
    
    // Add double tap gesture to allow the user to double tap the name of the sample to add to given track
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.sampleNameLabel addGestureRecognizer:doubleTap];
    [self.sampleNameLabel setUserInteractionEnabled:YES];
    
}


- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
    [self.tracksSingleton changeTrackSample: self.sampleName : self.tracksSingleton.soundDatabaseSegementedTrackValue: self.sampleFileType];

}

// This links the button on the sample cell with the sample data file to play when the users presses the button
- (IBAction)previewSampleButtonPressed:(id)sender {
    NSString *sampleFilePath = [[NSBundle mainBundle]pathForResource:self.sampleName ofType:self.sampleFileType];
    NSURL *sampleURL = [NSURL fileURLWithPath:sampleFilePath];
    player =[[AVAudioPlayer alloc] initWithContentsOfURL:sampleURL error:NULL];
    [player play];
    

}

@end
