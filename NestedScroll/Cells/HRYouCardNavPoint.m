//
//  HRYouCardNavPoint.m
//  NestedScroll
//
//  Created by Allen on 9/21/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardNavPoint.h"

@implementation HRYouCardNavPoint

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _state = HRYouCardNavPointStateToBeVisit;

        CAShapeLayer *visitingLayer = [CAShapeLayer layer];
        [visitingLayer addSublayer:[self circleLayerWithRect:self.bounds fill:NO opacity:1.f]];
        CGFloat inset = navBarPointInset + navBarLineWidth;
        [visitingLayer addSublayer:[self circleLayerWithRect:CGRectInset(self.bounds, inset, inset) fill:YES opacity:1.f]];
        visitingLayer.opacity = 0;
        [self.layer insertSublayer:visitingLayer atIndex:HRYouCardNavPointStateVisiting];

        [self.layer insertSublayer:[self circleLayerWithRect:CGRectInset(self.bounds, navBarPointInset, navBarPointInset) fill:NO opacity:navBarOpacity] atIndex:HRYouCardNavPointStateToBeVisit];

        [self.layer insertSublayer:[self circleLayerWithRect:CGRectInset(self.bounds, navBarPointInset, navBarPointInset) fill:YES opacity:0] atIndex:HRYouCardNavPointStateVisited];
    }
    return self;
}

- (void)setState:(HRYouCardNavPointState)state
{
    if (state != _state) {
        ((CAShapeLayer *)[self.layer.sublayers objectAtIndex:_state]).opacity = 0;
        _state = state;
        ((CAShapeLayer *)[self.layer.sublayers objectAtIndex:_state]).opacity = navBarOpacity;
    }
}

- (CAShapeLayer *)circleLayerWithRect:(CGRect)rect fill:(BOOL)fill opacity:(float)opacity
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = navBarLineWidth;
    layer.fillColor = fill ? [UIColor whiteColor].CGColor : NULL;
    layer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, layer.lineWidth, layer.lineWidth)].CGPath;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.shouldRasterize = NO;
    layer.opacity = opacity;
    return layer;
}

+ (NSString *)cellName
{
    return NSStringFromClass([self class]);
}

@end
