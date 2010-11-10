//
//  PostParserOperation.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ParseOperation.h"

@class PostRecord;

@interface PostParserOperation : ParseOperation {
	PostRecord *postEntry;
	BOOL messageContext;
	BOOL firstpostContext;
	BOOL editContext;
}

- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate;

@end
