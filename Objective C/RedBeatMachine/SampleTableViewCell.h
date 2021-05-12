//
//  SampleTableViewCell.h
//  RedBeatMachine
//
//  Created by LJ on 5/5/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleTableViewCell : UITableViewCell
@property (nonatomic) NSString *sampleName;      // Name of the sample audio file
@property (nonatomic) NSString *sampleFileType;  // Type of the sample audio file

- (void) formatCell;                             // This adds the correct sample name and file type to the cell. The label is also formatted
@end
