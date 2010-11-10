//
//  SectionParserOperation.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "SectionParserOperation.h"
#import "SectionRecord.h"
#import "BoardRecord.h"

static NSString *kNameStr = @"name";
static NSString *kDescriptionStr = @"description";
static NSString *kSectionStr = @"category";
static NSString *kBoardsStr = @"boards";
static NSString *kBoardStr = @"board";

@implementation SectionParserOperation

@synthesize boardEntries;

- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate {
	NSArray *elements = [NSArray arrayWithObjects:kNameStr, kDescriptionStr, kSectionStr, kBoardStr, kBoardsStr, nil];
	self = [super initWithDelegate:theDelegate elementsToParse:elements];
	
	if (self != nil) {
		self.boardEntries = [NSMutableArray array];
		boardContext = NO;
	}
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
										namespaceURI:(NSString *)namespaceURI
									   qualifiedName:(NSString *)qName
										  attributes:(NSDictionary *)attributeDict
{	
    if ([elementName isEqualToString:kSectionStr]) {
        workingEntry = [[[SectionRecord alloc] init] autorelease];
    } 
	
	if ([elementName isEqualToString:kBoardsStr]) {
		boardContext = YES;
	}
	
	if (boardContext && [elementName isEqualToString:kBoardStr]) {
		boardEntry = [[[BoardRecord alloc] init] autorelease];
		[boardEntry setBoardId:[[attributeDict objectForKey:@"id"] integerValue]];
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
			
			if (!boardContext) {				
				if ([elementName isEqualToString:kNameStr]) {
					[workingEntry setName:trimmedString];
				} else if ([elementName isEqualToString:kDescriptionStr]) {        
					[workingEntry setTitle:trimmedString];
				}
			} else {
				if ([elementName isEqualToString:kNameStr]) {
					[boardEntry setName:trimmedString];
				} else if ([elementName isEqualToString:kDescriptionStr]) {        
					[boardEntry setDescription:trimmedString];
				}
			}
        }
		if ([elementName isEqualToString:kSectionStr]) {
            [workingArray addObject:workingEntry];  
            workingEntry = nil;
        } 
		if ([elementName isEqualToString:kBoardStr]) {
			[boardEntries addObject:boardEntry];
			boardEntry = nil;
		}
		if ([elementName isEqualToString:kBoardsStr]) {
			[workingEntry setBoardRecords:boardEntries];
			boardEntries = [NSMutableArray array];
			boardContext = NO;
		}
    }
}

@end
