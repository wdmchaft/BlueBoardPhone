//
//  BBPostEntryCell.h
//  modsde
//
//  Created by Kristof Dreier on 12.01.10.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BBPostEntryCell : UITableViewCell {
	IBOutlet UIWebView *contentView;
	IBOutlet UILabel *authorLabel;
}

@property (nonatomic, retain) UIWebView *contentView;
@property (nonatomic, retain) UILabel *authorLabel;

@end
