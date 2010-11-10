//
//  StringHelper.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 11.08.10.
//  Copyright 2010. All rights reserved.
//

#import "StringHelper.h"


@implementation NSString (StringHelper)

- (CGFloat)RAD_textHeightForSystemFontOfSize:(CGFloat)size {
    //Calculate the expected size based on the font and linebreak mode of the label
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maximumLabelSize = CGSizeMake(maxWidth,maxHeight);
	
    CGSize expectedLabelSize = [self sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeWordWrap]; 
	
    return expectedLabelSize.height;
}

- (UILabel *)RAD_sizeCellLabelWithSystemFontOfSize:(CGFloat)size {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat height = [self RAD_textHeightForSystemFontOfSize:size] + 10.0;
    CGRect frame = CGRectMake(10.0f, 10.0f, width, height);
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:frame];
    cellLabel.textColor = [UIColor blackColor];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textAlignment = UITextAlignmentLeft;
    cellLabel.font = [UIFont systemFontOfSize:size];
	
    cellLabel.text = self; 
    cellLabel.numberOfLines = 0; 
    [cellLabel sizeToFit];
    return cellLabel;
}

@end
