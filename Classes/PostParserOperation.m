//
//  PostParserOperation.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "PostParserOperation.h"
#import "PostRecord.h"
#import "UserRecord.h"

static NSString *kFirstPostStr = @"firstpost";
static NSString *kPostStr = @"post";
static NSString *kUserStr = @"user";
static NSString *kDateStr = @"date";
static NSString *kMessageStr = @"message";
static NSString *kContentStr = @"content";

@implementation PostParserOperation

- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate
{
	NSArray *elements = [NSArray arrayWithObjects:kPostStr, kUserStr, kDateStr, 
						 kMessageStr, kContentStr, kFirstPostStr, nil];
	
	self = [super initWithDelegate:theDelegate elementsToParse:elements];
	
	if (self != nil) {
		messageContext = NO;
		firstpostContext = NO;
		editContext = NO;
	}
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
										namespaceURI:(NSString *)namespaceURI
									   qualifiedName:(NSString *)qName
										  attributes:(NSDictionary *)attributeDict
{	
    if ([elementName isEqualToString:kPostStr] && !firstpostContext) {
        workingEntry = [[[PostRecord alloc] init] autorelease];
    } 
	
	if ([elementName isEqualToString:kFirstPostStr]) {
		firstpostContext = YES;
	}	
	
	if ([elementName isEqualToString:kMessageStr]) {
		messageContext = YES;
	}
	
	storingCharacterData = [elementsToParse containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
									  namespaceURI:(NSString *)namespaceURI
									 qualifiedName:(NSString *)qName
{
    if (workingEntry) {
        if (storingCharacterData) {
			NSLog(@"%@", elementName);
			NSLog(@"%@", workingPropertyString);
			NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
									   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
			[workingPropertyString setString:@""];  // clear the string for next time
			
			if (!messageContext) {
				if ([elementName isEqualToString:kUserStr]) {
					UserRecord *userEntry = [[UserRecord alloc] init];
					userEntry.nickname = trimmedString;
					[workingEntry setUser:userEntry];
					[userEntry release];
				}
			} else {
				if ([elementName isEqualToString:kContentStr]) {        
					[workingEntry setContent:trimmedString];
				}
			}
        }
		
		if ([elementName isEqualToString:kPostStr]) {
			[workingArray addObject:workingEntry];  
			workingEntry = nil;
		}
		
		if ([elementName isEqualToString:kMessageStr]) {
			messageContext = NO;
		}
    }
	
	if ([elementName isEqualToString:kFirstPostStr]) {
		firstpostContext = NO;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (storingCharacterData && !firstpostContext)
    {
        [workingPropertyString appendString:string];
    }
}

@end
