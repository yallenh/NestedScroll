//
//  UIViewController+ATMContainment.h
//  Atom
//
//  Created by Yutung (Bob) Liu on 9/14/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

// Place containment related helpers here. If controller switching animation is needed in the future, the can be added here

@interface UIViewController (ATMContainment)

- (void)atm_removeChildControllerHelper:(UIViewController *)childController;
- (void)atm_addChildControllerHelper:(UIViewController *)childController toParentView:(UIView *)parentView;

@end
