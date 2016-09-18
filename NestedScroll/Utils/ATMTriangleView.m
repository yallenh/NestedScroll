//
//  ATMTriangleView.m
//  Atom
//
//  Created by Alex Y Wang on 8/4/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "ATMTriangleView.h"

@interface ATMTriangleView()

@property (nonatomic, strong) UIBezierPath* trianglePath;

@end

@implementation ATMTriangleView

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color orientation:(ATMTriangleOrientation)orientation
{
    self = [super initWithFrame:frame];
    if (self) {
        self.trianglePath = [UIBezierPath bezierPath];
        
        self.backgroundColor = color;
        self.orientation = orientation;
        
        [super setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    [self setNeedsDisplay];
}

-(void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self setNeedsDisplay];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

-(void)setOrientation:(ATMTriangleOrientation)orientation
{
    _orientation = orientation;
    [self setNeedsDisplay];
}

-(void)setupTriangleViewPathForTriangleOrientation:(ATMTriangleOrientation)orientation inContext:(CGContextRef)context;
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGAffineTransform transform = self.transform;
    switch (orientation) {
        case ATMTriangleDown:
            CGPathMoveToPoint   (path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));  // top left
            CGPathAddLineToPoint(path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));  // top right
            CGPathAddLineToPoint(path, &transform,  CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom middle
            break;
        case ATMTriangleUp:
            CGPathMoveToPoint   (path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom left
            CGPathAddLineToPoint(path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom right
            CGPathAddLineToPoint(path, &transform,  CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds));  // top middle
            break;
        case ATMTriangleTopToRight:
            CGPathMoveToPoint   (path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));  // top left
            CGPathAddLineToPoint(path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));  // top right
            CGPathAddLineToPoint(path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom right
            break;
        case ATMTriangleTopToLeft:
            CGPathMoveToPoint   (path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));  // top right
            CGPathAddLineToPoint(path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));  // top left
            CGPathAddLineToPoint(path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom left
            break;
        case ATMTriangleBottomToLeft:
            CGPathMoveToPoint   (path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom righ
            CGPathAddLineToPoint(path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));  // top left
            CGPathAddLineToPoint(path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom left
            break;
        case ATMTriangleBottomToRight:
            CGPathMoveToPoint   (path, &transform,  CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom left
            CGPathAddLineToPoint(path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds));  // top right
            CGPathAddLineToPoint(path, &transform,  CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));  // bottom right
            break;
        default:
            break;
    }
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    
    CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
    CGContextFillPath(context);
    
    self.trianglePath.CGPath = path;
    
    CGPathRelease(path);
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self setupTriangleViewPathForTriangleOrientation:self.orientation inContext:context];
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGAffineTransform transform = self.transform;
    return CGPathContainsPoint(self.trianglePath.CGPath, &transform, point, true);
}

@end
