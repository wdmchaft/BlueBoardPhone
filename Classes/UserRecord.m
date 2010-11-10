//
//  UserRecord.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "UserRecord.h"


@implementation UserRecord

@synthesize userId;
@synthesize nickname;
@synthesize avatar;

- (void)dealloc {
	[nickname release];
	[avatar release];
	
	[super dealloc];
}

@end
