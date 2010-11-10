//
//  SectionParserOperation.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ParseOperation.h"

@class BoardRecord;

@interface SectionParserOperation : ParseOperation {
	BOOL boardContext;
	BoardRecord *boardEntry;
	NSMutableArray *boardEntries;
}

@property (nonatomic, retain) NSMutableArray *boardEntries;

- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate;

@end
