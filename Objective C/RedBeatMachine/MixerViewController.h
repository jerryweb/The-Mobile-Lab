//
//  MixerViewController.h
//  RedBeatMachine
//
//  Created by LJ on 5/3/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>{
    IBOutlet UICollectionView *mixerTracks;
}

@end
