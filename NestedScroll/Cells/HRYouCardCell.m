//
//  HRYouCardCell.m
//  NestedScroll
//
//  Created by Allen on 9/19/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardCell.h"
#import "NSString+HRSSSize.h"

@implementation HRYouCardCell

- (CGFloat)heightForLabelText:(NSString *)text fontSize:(CGFloat)fontSize
{
    return ceil([text hrss_sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:labelSize].height);
}

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

@end
