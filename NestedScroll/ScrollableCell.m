//
//  ScrollableCell.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ScrollableCell.h"
#import "CardsCollectionView.h"

@interface ScrollableCell() <UIScrollViewDelegate>
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) CGFloat offsetY;
@end

@implementation ScrollableCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpScrollView];
    }
    return self;
}

- (void)setUpScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(self.frame) - 2 * 20, CGRectGetHeight(self.frame))];
    _scrollView.delegate = self;
    _scrollView.canCancelContentTouches = NO;
    _scrollView.delaysContentTouches = YES;
    [self addSubview:_scrollView];
}

- (void)populateData:(id)data
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    self.idx = [(NSNumber *)data unsignedIntegerValue];
    if (self.idx % 2) {
        _scrollView.contentSize = _scrollView.frame.size;
        _scrollView.backgroundColor = [UIColor grayColor];
        CardsCollectionView *cardsCollectionView = (CardsCollectionView *)[self superview];
        cardsCollectionView.scrollEnabled = YES;
    }
    else {
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), 1000);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
}

- (CGFloat)contentHeight
{
    return _scrollView.contentSize.height;
}
- (CGFloat)contentOffsetY
{
    return _scrollView.contentOffset.y;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[self superview];
    if ([self contentHeight] <= CGRectGetHeight(self.frame)) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionVertical;
    }
    return YES;
}

#pragma mark scroll view delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _offsetY = _scrollView.contentOffset.y;

    /*

    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[self superview];
    // at top
    if (_scrollView.contentOffset.y <= 0 && self.idx) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionUp;
    }
    // at bottom
    else if (_scrollView.contentOffset.y + CGRectGetHeight(self.frame) >= _scrollView.contentSize.height  && self.idx < 6) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionDown;
    }
    else {
        outerCollectionView.scrollEnabled = NO;
    }
     */
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat newOffsetY = _scrollView.contentOffset.y;
    
    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[self superview];
    // at top
    if ([self offsetY] <= 0 && self.idx) {
        
        // scroll up
        if (newOffsetY < _offsetY) {
            outerCollectionView.scrollEnabled = YES;
            outerCollectionView.scrollDirection = ScrollDirectionUp;
        }
        // scroll down
        else {
            
        }
        
    }
    // at bottom
    if ([self contentOffsetY] + CGRectGetHeight(self.frame) >= [self contentHeight]  && self.idx < 6) {
        
        // scroll up
        if (newOffsetY < _offsetY) {
            
        }
        // scroll down
        else {
            outerCollectionView.scrollEnabled = YES;
            outerCollectionView.scrollDirection = ScrollDirectionDown;
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat newOffsetY = _scrollView.contentOffset.y;
    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[self superview];
    // at top
    if ([self offsetY] <= 0 && newOffsetY < _offsetY) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionUp;
        [outerCollectionView scrollOneStep:ScrollDirectionUp];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*
    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[self superview];

    // at top
    if (_scrollView.contentOffset.y <= 0 && self.idx) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionUp;
    }
    // at bottom
    else if (_scrollView.contentOffset.y + CGRectGetHeight(self.frame) >= _scrollView.contentSize.height  && self.idx < 6) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionDown;
    }
    else {
        outerCollectionView.scrollEnabled = NO;
    }
     */
}

@end
