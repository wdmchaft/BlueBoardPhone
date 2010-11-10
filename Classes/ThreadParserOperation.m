//
//  ThreadParserOperation.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ThreadParserOperation.h"
#import "ThreadRecord.h"

static NSString *kThreadStr = @"thread";
static NSString *kTitleStr = @"title";
static NSString *kSubtitleStr = @"subtitle";
static NSString *kReplyCountStr = @"number-of-replies";
static NSString *kHitCountStr = @"number-of-hits";

@implementation ThreadParserOperation

- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate
{
	NSArray *elements = [NSArray arrayWithObjects:kThreadStr, kTitleStr, kSubtitleStr, kReplyCountStr, kHitCountStr, nil];
	
	self = [super initWithDelegate:theDelegate elementsToParse:elements];

	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{	
    if ([elementName isEqualToString:kThreadStr]) {
        workingEntry = [[[ThreadRecord alloc] init] autorelease];
		[workingEntry setThreadId:[[attributeDict objectForKey:@"id"] integerValue]];
    } 
	
	storingCharacterData = [elementsToParse containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if (workingEntry) {
        if (storingCharacterData) {
			NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
									   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
			[workingPropertyString setString:@""];  // clear the string for next time
		
			if ([elementName isEqualToString:kTitleStr]) {
				[workingEntry setTitle:trimmedString];
			} else if ([elementName isEqualToString:kSubtitleStr]) {        
				[workingEntry setSubtitle:trimmedString];
			}
        }
		
		if ([elementName isEqualToString:kThreadStr]) {
            [workingArray addObject:workingEntry];  
            workingEntry = nil;
        } 
    }
}

@end
