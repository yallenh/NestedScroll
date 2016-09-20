//
//  HRYouCardBulletPointItem.m
//  NestedScroll
//
//  Created by Allen on 9/20/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardBulletPointItem.h"
#import "HRGraphicsFactory.h"
#import <MNColorKit/MNColorKit.h>
#define kHRYouCardBulletPointStart RGBXA(0x2dc2bb, 1.f)
#define kHRYouCardBulletPointEnd RGBXA(0x1db2e8, 1.f)

@interface HRYouCardBulletPointItem ()

@property (weak, nonatomic) IBOutlet UIView *bulletPoint;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation HRYouCardBulletPointItem

- (void)awakeFromNib {
    [super awakeFromNib];

    CAGradientLayer *layer = [[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardBulletPointStart, kHRYouCardBulletPointEnd] gradientType:kHRGraphicsFactoryGradientTypeVertical points:nil size:self.bulletPoint.frame.size];
    layer.cornerRadius = self.bulletPoint.layer.cornerRadius;
    [self.bulletPoint.layer insertSublayer:layer atIndex:0];

    self.title.text = nil;
    self.title.font = [UIFont systemFontOfSize:bulletPointTitleFontSize];
}

- (void)setText:(NSString *)text
{
    self.title.text = text;
}

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

@end
