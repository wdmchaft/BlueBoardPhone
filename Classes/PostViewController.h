//
//  PostßViewController.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 09.08.10.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConnectionDelegate;

@interface PostViewController : UITableViewController {
	NSInteger threadId;
	NSArray *entries;
	ConnectionDelegate *connection;
}

@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, assign) NSInteger threadId;
@property (nonatomic, retain) ConnectionDelegate *connection;

@end

