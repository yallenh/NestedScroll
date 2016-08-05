//
//  CardsCollectionView.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/4/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "CardsCollectionView.h"
#import "ScrollableCell.h"

@interface CardsCollectionView () <
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate
>
@property (nonatomic) CGFloat offsetY;
@property (nonatomic) NSUInteger currentIndex;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan on collectionview");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    NSLog(@"touchesMoved on collectionview");
}

#pragma mark scroll view delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _offsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if ((self.scrollDirection == ScrollDirectionDown && newOffsetY < _offsetY) ||
        (self.scrollDirection == ScrollDirectionUp && newOffsetY > _offsetY)) {
        [scrollView setContentOffset:CGPointMake(0, _offsetY)];
    }
    self.currentIndex = (NSUInteger)(newOffsetY / CGRectGetHeight(self.frame) + 0.5f);
    NSLog(@"%tu", self.currentIndex);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // NSLog(@"scrollViewWillBeginDecelerating");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // NSLog(@"scrollViewDidEndDecelerating");
    self.scrollDirection = ScrollDirectionVertical;

    /*
    [[self visibleCells] enumerateObjectsUsingBlock:^(ScrollableCell *cell, NSUInteger idx, BOOL *stop) {
        if (cell.idx == self.currentIndex) {
            if (cell.contentHeight > CGRectGetHeight(cell.frame)) {
                self.scrollEnabled = NO;
            }
            else {
                self.scrollDirection = ScrollDirectionVertical;
                self.scrollEnabled = YES;
            }
        }
    }];
    // self.scrollEnabled = NO;
     */
}

@end
