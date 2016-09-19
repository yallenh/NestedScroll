//
//  HRScrollableCell.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/8/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRScrollableCell.h"

#import "HRYouCardCoverView.h"
#import "HRYouCardStoryView.h"

@interface HRScrollableCell() <UIScrollViewDelegate>
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView<HRYouCardViewProtocol> *cardView;
@end

@implementation HRScrollableCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpScrollView];
        
        
        _cardView = [HRYouCardStoryView cardView];
        [_scrollView addSubview:_cardView];
    }
    return self;
}

- (void)setUpScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.frame, 10.f, 10.f)];
    _scrollView.delegate = self;
    _scrollView.canCancelContentTouches = NO;
    _scrollView.delaysContentTouches = YES;
    [self addSubview:_scrollView];
}

- (void)populateData:(id)data
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [_cardView populateWithDataSourceItem:nil forSize:_scrollView.frame.size];

    _scrollView.contentSize = _cardView.frame.size;
    _scrollView.backgroundColor = [UIColor whiteColor];
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
