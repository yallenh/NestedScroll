//
//  ViewController.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "ScrollableCell.h"
#import "CardsCollectionView.h"

@interface ViewController() <UICollectionViewDataSource>
@property (nonatomic) CardsCollectionView *cardsCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCardsCollectionView];
}

- (void)setUpCardsCollectionView
{
    self.view.frame = [[UIScreen mainScreen] bounds];
    _cardsCollectionView = [[CardsCollectionView alloc] initWithFrame:self.view.frame];
    [_cardsCollectionView setDataSource:self];
    [_cardsCollectionView registerClass:[ScrollableCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:_cardsCollectionView];
}

#pragma mark collection view delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScrollableCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell populateData:[NSNumber numberWithUnsignedInteger:[indexPath row]]];
    switch ([indexPath row]) {
        case 0:
            cell.backgroundColor=[UIColor redColor];
            break;
        case 1:
            cell.backgroundColor=[UIColor orangeColor];
            break;
        case 2:
            cell.backgroundColor=[UIColor yellowColor];
            break;
        case 3:
            cell.backgroundColor=[UIColor greenColor];
            break;
        case 4:
            cell.backgroundColor=[UIColor blueColor];
            break;
        case 5:
            cell.backgroundColor=[UIColor purpleColor];
            break;
        default:
            cell.backgroundColor=[UIColor whiteColor];
            break;
    }
    return cell;
}

@end
