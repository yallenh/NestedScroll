//
//  HRGraphicsFactory.h
//  NestedScroll
//
//  Created by Allen on 9/19/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HRGraphicsFactoryGradientType)  {
    kHRGraphicsFactoryGradientTypeHorizontal,
    kHRGraphicsFactoryGradientTypeVertical,
    kHRGraphicsFactoryGradientTypeBottomLeftToUpperRight
};

@interface HRGraphicsFactory : NSObject

+ (instancetype)sharedFactory;

- (CAGradientLayer *)generateGradientLayerWithColors:(NSArray *)colorArray gradientType:(HRGraphicsFactoryGradientType)gradientType points:(NSArray *)points size:(CGSize)size;

@end
