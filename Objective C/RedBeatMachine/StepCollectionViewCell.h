//
//  StepCollectionViewCell.h
//  RedBeatMachine
//
//  Created by LJ on 5/6/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This holds one public method that allows the cell to be created and formated when the collection view is created

#import <UIKit/UIKit.h>
#import "TrackModel.h"


@interface StepCollectionViewCell : UICollectionViewCell

- (void) setupCell: (TrackModel *) track : (NSInteger) num: (NSInteger) beatNumber;
@end
