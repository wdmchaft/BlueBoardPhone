//
//  SectionRecord.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BoardRecord;

@interface SectionRecord : NSObject {
	NSInteger sectionId;
	NSString *name;
	NSString *title;
	NSMutableArray *boardRecords;
}

@property (nonatomic) NSInteger sectionId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSMutableArray *boardRecords;

@end
