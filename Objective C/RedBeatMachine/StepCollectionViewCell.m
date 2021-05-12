//
//  StepCollectionViewCell.m
//  RedBeatMachine
//
//  Created by LJ on 5/6/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This class formats the collection veiw cell which holds only one button which represents if the sample will play at that beat time step. If play is set to true, then the sample will play at that timestep during play.
#import "SequencerModel.h"
#import "StepCollectionViewCell.h"
#import "TracksSingleton.h"

@interface StepCollectionViewCell()
@property (strong, nonatomic) TracksSingleton *tracksSingleton;
@property (strong, nonatomic) SequencerModel *sequencerModel;

@property (nonatomic) NSInteger trackNumber;    // corresponding track that the step is associated with
@property (nonatomic) NSInteger sectionNumber;       // 0 through 15 for a 16 beat pattern loop
@property (nonatomic) BOOL playSample;
@property (weak, nonatomic) IBOutlet UIButton *stepButton;
@end

@implementation StepCollectionViewCell
- (void) setupCell: (TrackModel *) track : (NSInteger) num: (NSInteger) beatNumber{
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];

    [self.stepButton setImage:[UIImage imageNamed:@"squareUnchecked.png"] forState:UIControlStateNormal];                  // Set the button to unchecked
    
    self.trackNumber = num;                // Corresponding audio track
    self.sectionNumber = beatNumber;               // Step number corresponding to the location within the pattern
    NSMutableArray *row = self.sequencerModel.steps2DArray[self.sectionNumber];
    if([row[self.trackNumber] boolValue]){
        self.playSample = YES;                       // Default to false
        [self.stepButton setImage:[UIImage imageNamed:@"square.png"] forState:UIControlStateNormal];
    }
    else {
        self.playSample = NO;
    }

}

- (IBAction)stepButtonPressed:(id)sender {
    NSMutableArray *row = self.sequencerModel.steps2DArray[self.sectionNumber];
    
    // toggle the step boolean value
    if([row[self.trackNumber] boolValue]){
        [self.stepButton setImage:[UIImage imageNamed:@"squareUnchecked.png"] forState:UIControlStateNormal];
        self.playSample = NO;
        [row replaceObjectAtIndex:self.trackNumber withObject:@"NO"];

    }
    else {
        [self.stepButton setImage:[UIImage imageNamed:@"square.png"] forState:UIControlStateNormal];
        self.playSample = YES;
        [row replaceObjectAtIndex:self.trackNumber withObject:@"YES"];

    }
    NSLog(@"section number is: %ld. track number is: %ld", (long)self.sectionNumber, (long)self.trackNumber);
    
    [self.sequencerModel.steps2DArray replaceObjectAtIndex:self.sectionNumber withObject:row];

}






@end
