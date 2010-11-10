//
//  PostRecord.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserRecord;

@interface PostRecord : NSObject {
	NSInteger postId;
	UserRecord *user;
	NSDate *date;
	NSInteger editCount;
	NSString *content;
	NSString *title;
}

@property (nonatomic) NSInteger postId;
@property (nonatomic, retain) UserRecord *user;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic) NSInteger editCount;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *title;

@end
