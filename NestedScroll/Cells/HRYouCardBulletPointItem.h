//
//  HRYouCardBulletPointItem.h
//  NestedScroll
//
//  Created by Allen on 9/20/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat bulletPointTitleFontSize = 18.f;
static const CGFloat bulletPointLineSpacing = 10.f;

@interface HRYouCardBulletPointItem : UICollectionViewCell

@property (nonatomic) NSString *text;

+ (NSString *)nibName;

@end
