//
//  BoardRecord.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "BoardRecord.h"


@implementation BoardRecord

@synthesize boardId;
@synthesize name;
@synthesize description;
@synthesize threadCount;
@synthesize replyCount;
@synthesize lastPost;

- (void)dealloc {
	[name release];
	[description release];
	[lastPost release];
	
	[super dealloc];
}
	
@end
