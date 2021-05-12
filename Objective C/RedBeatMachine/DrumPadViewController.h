//
//  DrumPadViewController.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrumPadViewController : UIViewController

// Used to update the master volume slider if changed in the mixer view

- (void) modifyMasterVolume: (float) volume;

#pragma transport button events - these are the actions associated to the transport buttons (play, pause, stop, and record)

- (IBAction)togglePlayButton:(id)sender;

#pragma drumpad - Wire all 8 pads to like with the track model to play the samples when pressed
// First row of beat pads 0 - 3
@property (weak, nonatomic) IBOutlet UIButton *pad0;
@property (weak, nonatomic) IBOutlet UIButton *pad1;
@property (weak, nonatomic) IBOutlet UIButton *pad2;
@property (weak, nonatomic) IBOutlet UIButton *pad3;

// Second row of beat pads 4 - 7
@property (weak, nonatomic) IBOutlet UIButton *pad4;
@property (weak, nonatomic) IBOutlet UIButton *pad5;
@property (weak, nonatomic) IBOutlet UIButton *pad6;
@property (weak, nonatomic) IBOutlet UIButton *pad7;

// Connect the drum pad touch events to the track model
- (IBAction)triggerPad0:(id)sender;
- (IBAction)triggerPad1:(id)sender;
- (IBAction)triggerPad2:(id)sender;
- (IBAction)triggerPad3:(id)sender;
- (IBAction)triggerPad4:(id)sender;
- (IBAction)triggerPad5:(id)sender;
- (IBAction)triggerPad6:(id)sender;
- (IBAction)triggerPad7:(id)sender;
@end
