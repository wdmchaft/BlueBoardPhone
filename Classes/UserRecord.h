//
//  UserRecord.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRecord : NSObject {
	NSInteger userId;
	NSString *nickname;
	UIImage *avatar;
}

@property (nonatomic) NSInteger userId;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) UIImage *avatar;

@end
