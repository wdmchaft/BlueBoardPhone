//
//  ThreadRecord.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostRecord;

@interface ThreadRecord : NSObject {
	NSInteger threadId;
	NSString *title;
	NSString *subtitle;
	NSInteger replyCount;
	NSInteger hitCount;
	PostRecord *firstPost;
	BOOL closed;
	BOOL sticky;
	BOOL important;
	BOOL annoucement;
	BOOL global;
}

@property (nonatomic) NSInteger threadId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic) NSInteger replyCount;
@property (nonatomic) NSInteger hitCount;
@property (nonatomic, retain) PostRecord *firstPost;
@property (nonatomic, getter=isClosed) BOOL closed;
@property (nonatomic, getter=isSticky) BOOL sticky;
@property (nonatomic, getter=isImportant) BOOL important;
@property (nonatomic, getter=isAnnoucement) BOOL annoucement;
@property (nonatomic, getter=isGlobal) BOOL global;

@end
