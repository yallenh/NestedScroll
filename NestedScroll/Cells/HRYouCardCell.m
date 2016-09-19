//
//  HRYouCardCell.m
//  NestedScroll
//
//  Created by Allen on 9/19/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardCell.h"
#import "NSString+HRSSSize.h"
#import "ATMTriangleView.h"

@implementation HRYouCardCell

- (CGFloat)heightForLabelText:(NSString *)text fontSize:(CGFloat)fontSize
{
    return ceil([text hrss_sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:labelSize].height);
}

- (void)addTriangleOnView:(UIView *)view
{
    ATMTriangleView *triangle = [[ATMTriangleView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame) - triangleHeight, CGRectGetWidth(view.frame), triangleHeight) color:[UIColor whiteColor] orientation:ATMTriangleBottomToRight];
    triangle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [view addSubview:triangle];
}

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

@end
