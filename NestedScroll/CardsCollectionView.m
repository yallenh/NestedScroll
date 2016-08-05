//
//  CardsCollectionView.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/4/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "CardsCollectionView.h"

@interface CardsCollectionView () <
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate
>
@property (nonatomic) CGPoint offset;
@end

@implementation CardsCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = frame.size;

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor blackColor];
        self.pagingEnabled = YES;
        self.delegate = self;
        self.scrollDirection = ScrollDirectionDown;
    }
    return self;
}

#pragma mark scroll view delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _offset = scrollView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint newOffset = scrollView.contentOffset;
    if ((self.scrollDirection == ScrollDirectionDown && newOffset.y < _offset.y) ||
        (self.scrollDirection == ScrollDirectionUp && newOffset.y > _offset.y)) {
        [scrollView setContentOffset:_offset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.scrollDirection = ScrollDirectionVertical;
    // self.scrollEnabled = NO;
}

@end
