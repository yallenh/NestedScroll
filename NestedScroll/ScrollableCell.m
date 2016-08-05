//
//  ScrollableCell.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ScrollableCell.h"
#import "CardsCollectionView.h"
#import "BaseCard.h"

@interface ScrollableCell()
@property (nonatomic) BaseCard *card;
@end

@implementation ScrollableCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpBaseCard];
    }
    return self;
}

- (void)setUpBaseCard
{
    _card = [[BaseCard alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(self.frame) - 2 * 20, CGRectGetHeight(self.frame))];
    [self addSubview:_card];
}

- (void)populateData:(id)data
{
    [_card setContentOffset:CGPointMake(0, 0) animated:NO];

    _card.idx = [(NSNumber *)data unsignedIntegerValue];
    if (_card.idx % 2) {
        _card.contentSize = _card.frame.size;
        _card.backgroundColor = [UIColor grayColor];
        CardsCollectionView *cardsCollectionView = (CardsCollectionView *)[self superview];
        cardsCollectionView.scrollEnabled = YES;
    }
    else {
        _card.contentSize = CGSizeMake(CGRectGetWidth(_card.frame), 1000);
        _card.backgroundColor = [UIColor whiteColor];
    }
}

@end
