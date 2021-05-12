//
//  SequenceViewController.h
//  RedBeatMachine
//
//  Created by LJ on 5/6/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SequenceViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource> {
    IBOutlet UICollectionView *stepSequenceCollectionView;
}


@end
