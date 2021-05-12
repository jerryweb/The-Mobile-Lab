//
//  TrackNameCollectionViewCell.h
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackModel.h"

@interface TrackNameCollectionViewCell : UICollectionViewCell

- (void) setupTrackNameCell: (TrackModel *) track : (NSInteger) trackNumber;


@end
