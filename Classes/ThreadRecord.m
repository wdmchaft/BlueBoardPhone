//
//  ThreadRecord.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ThreadRecord.h"


@implementation ThreadRecord

@synthesize threadId;
@synthesize title;
@synthesize subtitle;
@synthesize replyCount;
@synthesize hitCount;
@synthesize firstPost;
@synthesize closed;
@synthesize sticky;
@synthesize important;
@synthesize annoucement;
@synthesize global;

- (void)dealloc {
	[title release];
	[subtitle release];
	[firstPost release];
	
	[super dealloc];
}

@end
