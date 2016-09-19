//
//  HRYouCardCell.h
//  NestedScroll
//
//  Created by Allen on 9/19/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRYouCardViewProtocol.h"

static const CGSize labelSize = {270.f ,0};
static const CGFloat lineHeightFactor = 1.2;
static const CGFloat titleFontSize = 30.f;
static const CGFloat subTitleFontSize = 28.f;
static const CGFloat descFontSize = 18.f;
static const CGFloat providerFontSize = 14.f;
static const CGFloat triangleHeight = 25.f;
static const CGFloat infoTop = 20.f;

@interface HRYouCardCell : UICollectionViewCell <HRYouCardViewProtocol>

@property (nonatomic, weak) id<HRYouCardViewDelegate> cardViewDelegate;

+ (NSString *)nibName;

@end
