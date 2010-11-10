//
//  ConnectionDelegate.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 09.08.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"

@class ParseOperation;

@interface ConnectionDelegate : NSObject <ParseOperationDelegate> {
    NSOperationQueue *queue;
	ParseOperation *parser;
	
	NSURLConnection *listConnection;
	NSMutableData *listData;
	UITableViewController *viewController;
	NSMutableArray *entries;
}

- (id)initWithURL:(NSURL *)theURL parser:(ParseOperation *)theParser viewController:(UITableViewController *)theController;

@property (nonatomic, retain) UITableViewController *viewController;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) ParseOperation *parser;

@property (nonatomic, retain) NSURLConnection *listConnection;
@property (nonatomic, retain) NSMutableData *listData;
@property (nonatomic, retain) NSMutableArray *entries;


@end
