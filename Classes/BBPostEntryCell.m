//
//  BBPostEntryCell.m
//  modsde
//
//  Created by Kristof Dreier on 12.01.10.
//  Copyright 2010. All rights reserved.
//

#import "BBPostEntryCell.h"


@implementation BBPostEntryCell

@synthesize contentView, authorLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)dealloc {
    [super dealloc];
}


@end
