//
//  RootViewController.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 04.08.10.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConnectionDelegate;

@interface RootViewController : UITableViewController {
	NSArray *entries;
	ConnectionDelegate *connection;
}

@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, retain) ConnectionDelegate *connection;

@end
