//
//  ScrollableCell.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ScrollableCell.h"

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

@end
