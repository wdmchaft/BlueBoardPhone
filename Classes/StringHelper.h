//
//  StringHelper.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 11.08.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (StringHelper)
- (CGFloat)RAD_textHeightForSystemFontOfSize:(CGFloat)size;
- (UILabel *)RAD_sizeCellLabelWithSystemFontOfSize:(CGFloat)size;
@end