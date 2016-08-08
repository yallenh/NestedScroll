//
//  ViewController.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "HRScrollableCell.h"

@interface ViewController() <
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>
@property (nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];
}

- (void)setUpCollectionView
{
    self.view.frame = [[UIScreen mainScreen] bounds];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = self.view.frame.size;

    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.pagingEnabled = YES;
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView registerClass:[HRScrollableCell class] forCellWithReuseIdentifier:@"cellIdentifier"];

    [self.view addSubview:_collectionView];
}

#pragma mark collection view delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRScrollableCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
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
