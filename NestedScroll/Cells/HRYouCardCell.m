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

- (CGFloat)widthForLabelText:(NSString *)text fontSize:(CGFloat)fontSize
{
    return ceil([text hrss_sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width);
}

- (void)setUpCoverImageView:(UIImageView *)view
{
    ATMTriangleView *triangle = [[ATMTriangleView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame) - triangleHeight, CGRectGetWidth(view.frame), triangleHeight) color:[UIColor whiteColor] orientation:ATMTriangleBottomToRight];
    triangle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [view addSubview:triangle];
}

- (void)setUpProviderView:(UIView *)view
{
    view.clipsToBounds = NO;
    CGFloat triangleWidth = 18.f;
    CGFloat triangleHeight = 9.f;
    CGFloat triangleBorder = providerViewBorderWidth + 1.f;
    ATMTriangleView *triangleOut = [[ATMTriangleView alloc] initWithFrame:CGRectMake(24.f, CGRectGetHeight(view.frame) - providerViewBorderWidth, triangleWidth, triangleHeight) color:view.backgroundColor orientation:ATMTriangleDown];
    ATMTriangleView *triangleIn = [[ATMTriangleView alloc] initWithFrame:CGRectMake(triangleBorder, 0, triangleWidth - 2 * triangleBorder, triangleHeight - triangleBorder) color:[UIColor whiteColor] orientation:ATMTriangleDown];
    [triangleOut addSubview:triangleIn];
    [view addSubview:triangleOut];
    view.hidden = YES;
}

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

@end
