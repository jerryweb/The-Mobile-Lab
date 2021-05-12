//
//  MixerTrackCollectionViewCell.h
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This holds one public method that allows the cell to be created and formated when the collection view is created

#import <UIKit/UIKit.h>
#import "TrackModel.h"


@interface MixerTrackCollectionViewCell : UICollectionViewCell

- (void) setupCell: (TrackModel *) track : (NSInteger) trackNumber;

@end
