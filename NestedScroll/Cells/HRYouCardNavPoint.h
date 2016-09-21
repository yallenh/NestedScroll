//
//  HRYouCardNavPoint.h
//  NestedScroll
//
//  Created by Allen on 9/21/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HRYouCardNavPointState) {
    HRYouCardNavPointStateVisiting,
    HRYouCardNavPointStateToBeVisit,
    HRYouCardNavPointStateVisited
};

static const CGFloat navBarOpacity = .7f;
static const CGFloat navBarLineWidth = 1.f;
static const CGFloat navBarPointSize = 15.f;
static const CGFloat navBarPointInset = 3.f;

@interface HRYouCardNavPoint : UICollectionViewCell

@property (nonatomic) HRYouCardNavPointState state;

+ (NSString *)cellName;

@end
