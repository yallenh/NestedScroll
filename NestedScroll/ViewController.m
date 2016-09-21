//
//  ViewController.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"

#import "UIViewController+ATMContainment.h"
#import "HRYouCardViewController.h"

@interface ViewController()

@property (nonatomic) HRYouCardViewController *youCardViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.youCardViewController = [[HRYouCardViewController alloc] init];
    self.youCardViewController.view.frame = self.view.frame;
    [self atm_addChildControllerHelper:self.youCardViewController toParentView:self.view];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
