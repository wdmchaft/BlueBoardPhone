//
//  BoardRecord.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostRecord;

@interface BoardRecord : NSObject {
	NSInteger boardId;
	NSString *name;
	NSString *description;
	NSInteger threadCount;
	NSInteger replyCount;
	PostRecord *lastPost;
}

@property (nonatomic) NSInteger boardId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) NSInteger threadCount;
@property (nonatomic) NSInteger replyCount;
@property (nonatomic, retain) PostRecord *lastPost;

@end
