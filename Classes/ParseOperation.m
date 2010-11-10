//
//  ParseOperation.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ParseOperation.h"

@implementation ParseOperation

@synthesize delegate, dataToParse, workingArray, workingEntry, workingPropertyString, elementsToParse, storingCharacterData;

- (id)initWithData:(NSData *)data delegate:(id <ParseOperationDelegate>)theDelegate elementsToParse:(NSArray *)theElements
{
    self = [super init];
    
	if (self != nil) {
        self.dataToParse = data;
        self.delegate = theDelegate;
		self.elementsToParse = theElements;
    }
	
    return self;
}

- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate elementsToParse:(NSArray *)theElements
{
    self = [super init];
    
	if (self != nil) {
        self.delegate = theDelegate;
		self.elementsToParse = theElements;
    }
	
    return self;
}

// -------------------------------------------------------------------------------
//	dealloc:
// -------------------------------------------------------------------------------
- (void)dealloc
{
    [dataToParse release];
    [workingEntry release];
    [workingPropertyString release];
    [workingArray release];
    
    [super dealloc];
}

// -------------------------------------------------------------------------------
//	main:
//  Given data to parse, use NSXMLParser and process all the top paid apps.
// -------------------------------------------------------------------------------
- (void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	self.workingArray = [NSMutableArray array];
    self.workingPropertyString = [NSMutableString string];
    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is not
	// desirable because it gives less control over the network, particularly in responding to
	// connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataToParse];
	[parser setDelegate:self];
    [parser parse];
	
	if (![self isCancelled])
    {
        // notify our AppDelegate that the parsing is complete
        [self.delegate didFinishParsing:self.workingArray];
    }
    
    self.workingArray = nil;
    self.workingPropertyString = nil;
    self.dataToParse = nil;
    
    [parser release];
	
	[pool release];
}


#pragma mark -
#pragma mark RSS processing

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (storingCharacterData)
    {
        [workingPropertyString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [delegate parseErrorOccurred:parseError];
}

@end
