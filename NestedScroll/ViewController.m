//
//  ViewController.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "HRScrollableCell.h"
#import "HRYouCardStoryCell.h"

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
    layout.minimumInteritemSpacing = 0.f;
    layout.minimumLineSpacing = 0.f;
    layout.itemSize = self.view.frame.size;

    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.pagingEnabled = YES;
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    

    [_collectionView registerClass:[HRScrollableCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardStoryCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardStoryCell nibName]];
    
    // _collectionView.bounces = NO;
    
    [self.view addSubview:_collectionView];
}

#pragma mark collection view delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"populate %tu", indexPath.row);
    // HRScrollableCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    HRYouCardStoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardStoryCell nibName] forIndexPath:indexPath];
    [cell populateWithDataSourceItem:nil forSize:self.collectionView.frame.size];
    cell.backgroundColor=[UIColor orangeColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.frame.size;
}

@end
