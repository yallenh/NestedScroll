//
//  BaseCard.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/4/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "BaseCard.h"
#import "CardsCollectionView.h"

@interface BaseCard()
@end

@implementation BaseCard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint prevLocation = [touch previousLocationInView:self];

    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[[self superview] superview];

    // scroll up at top
    if ((location.y - prevLocation.y > 0) && (self.contentOffset.y <= 0) && self.idx) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionUp;
    }
    // scroll down at bottom
    else if ((location.y - prevLocation.y < 0) && (self.contentOffset.y + CGRectGetHeight(self.frame) >= self.contentSize.height) && self.idx < 6) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionDown;
    }
    else {
        outerCollectionView.scrollEnabled = NO;
    }
}

#pragma mark scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[[self superview] superview];

    // at top
    if (self.contentOffset.y <= 0 && self.idx) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionUp;
    }
    // at bottom
    else if (self.contentOffset.y + CGRectGetHeight(self.frame) >= self.contentSize.height  && self.idx < 6) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionDown;
    }
    else {
        outerCollectionView.scrollEnabled = NO;
    }
}

@end
