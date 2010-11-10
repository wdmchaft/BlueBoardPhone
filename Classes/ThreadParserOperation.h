//
//  ThreadParserOperation.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ParseOperation.h"

@class ThreadRecord;

@interface ThreadParserOperation : ParseOperation {
	ThreadRecord *threadEntry;
}

- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate;

@end
