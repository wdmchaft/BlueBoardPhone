//
//  ThreadViewController.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 09.08.10.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConnectionDelegate;

@interface ThreadViewController : UITableViewController {
	NSInteger boardId;
	NSArray *entries;
	ConnectionDelegate *connection;
}

@property (nonatomic, assign) NSInteger boardId;
@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, retain) ConnectionDelegate *connection;


@end

