//
//  SectionRecord.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "SectionRecord.h"


@implementation SectionRecord

@synthesize sectionId, name, title, boardRecords;

- (void)dealloc {
	[name release];
	[title release];
	[boardRecords release];
	
	[super dealloc];
}

@end
