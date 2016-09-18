//
//  HRYouCardView.m
//  NestedScroll
//
//  Created by Allen on 9/18/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardView.h"
#import "NSString+HRSSSize.h"

@implementation HRYouCardView

+ (UIView<HRYouCardViewProtocol>*)cardView
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    UIView<HRYouCardViewProtocol> *view = [[nib instantiateWithOwner:nil options:nil] lastObject];
    return view;
}

- (CGFloat)heightForLabelText:(NSString *)text fontSize:(CGFloat)fontSize
{
    return ceil([text hrss_sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:labelSize].height);
}

@end
