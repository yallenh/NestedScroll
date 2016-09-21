//
//  UIViewController+ATMContainment.m
//  Atom
//
//  Created by Yutung (Bob) Liu on 9/14/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "UIViewController+ATMContainment.h"

@implementation UIViewController (ATMContainment)

- (void)atm_removeChildControllerHelper:(UIViewController *)childController
{
    if (childController.parentViewController == nil) {
        return;
    }
    
    [childController willMoveToParentViewController:nil];
    [childController.view removeFromSuperview];
    [childController removeFromParentViewController];
}

- (void)atm_addChildControllerHelper:(UIViewController *)childController toParentView:(UIView *)parentView
{
    if (childController.parentViewController != nil) {
        [self atm_removeChildControllerHelper:childController];
    }
    
    [self addChildViewController:childController];
    [parentView addSubview:childController.view];
    [childController didMoveToParentViewController:self];
}

@end
