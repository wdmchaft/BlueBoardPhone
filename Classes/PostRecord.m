//
//  PostRecord.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "PostRecord.h"


@implementation PostRecord

@synthesize postId;
@synthesize user;
@synthesize date;
@synthesize editCount;
@synthesize content;
@synthesize title;

- (void)dealloc {
	[user release];
	[date release];
	[content release];
	[title release];
	
	[super dealloc];
}

@end
