//
//  SoundDatabaseTableViewController.m
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "SoundDatabaseTableViewController.h"
#import "TracksSingleton.h"
#import "SampleTableViewCell.h"


@interface SoundDatabaseTableViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *trackSampleSelector;
@property (strong, nonatomic) TracksSingleton *tracksSingleton;

@end

@implementation SoundDatabaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tracksSingleton = [TracksSingleton sharedModel];
    [self.trackSampleSelector setSelectedSegmentIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracksSingleton returnSizeOfSampleList];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SampleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SampleCell" forIndexPath:indexPath];
    
    NSDictionary *sample = [self.tracksSingleton returnSampleFromListOfSamples: indexPath.row];
    cell.sampleName = sample[kSampleNameKey];
    cell.sampleFileType = sample[kSampleFileTypeKey];
    
    [cell formatCell];
    
    return cell;
}

- (IBAction)trackSegmentedDisplayChanged:(id)sender {
    [self.tracksSingleton setSoundDatabaseSegementedTrackValue:self.trackSampleSelector.selectedSegmentIndex];
}
@end
