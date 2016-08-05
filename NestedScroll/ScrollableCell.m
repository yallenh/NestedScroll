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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_scrollView.contentSize.height <= self.frame.size.height) {
        CardsCollectionView *cardsCollectionView = (CardsCollectionView *)[[self superview] superview];
        cardsCollectionView.scrollEnabled = YES;
        cardsCollectionView.scrollDirection = ScrollDirectionVertical;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint prevLocation = [touch previousLocationInView:self];

    CardsCollectionView *outerCollectionView = (CardsCollectionView *)[[self superview] superview];

    // scroll up at top
    if ((location.y - prevLocation.y > 0) && (_scrollView.contentOffset.y <= 0) && self.idx) {
        outerCollectionView.scrollEnabled = YES;
        outerCollectionView.scrollDirection = ScrollDirectionUp;
    }
    // scroll down at bottom
    else if ((location.y - prevLocation.y < 0) && (_scrollView.contentOffset.y + CGRectGetHeight(self.frame) >= _scrollView.contentSize.height) && self.idx < 6) {
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
}

@end
