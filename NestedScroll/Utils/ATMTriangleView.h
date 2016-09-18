//
//  ATMTriangleView.h
//  Atom
//
//  Created by Alex Y Wang on 8/4/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ATMTriangleOrientation){
    ATMTriangleTopToRight,
    ATMTriangleTopToLeft,
    ATMTriangleBottomToRight,
    ATMTriangleBottomToLeft,
    ATMTriangleUp,
    ATMTriangleDown
};

@interface ATMTriangleView : UIView

/**
 *  backgroundColor overwrites UIView's background color.
 *  the real backgroundColor is always clearColor.
 *  Setting backgroundColor will change the fill color of triangle view.
 */
@property (nonatomic, strong) UIColor* backgroundColor;
@property (nonatomic, assign) ATMTriangleOrientation orientation;

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color orientation:(ATMTriangleOrientation)orientation;

@end