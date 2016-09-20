//
//  ViewController.m
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/3/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "HRScrollableCell.h"

// cells
#import "HRYouCardCoverCell.h"
#import "HRYouCardStoryCell.h"
#import "HRYouCardQuoteCell.h"

// utils
#import "HRGraphicsFactory.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MNColorKit/MNColorKit.h>

#define kHRStreamDefaultBackgroundColor RGBX(0xe0e0e7)
#define kHRYouCardGradient1Start RGBXA(0x30d3b6, 1.f)
#define kHRYouCardGradient1End RGBXA(0x30d3b6, 0)

#define kHRYouCardGradient2Start RGBXA(0x000000, 0.7)
#define kHRYouCardGradient2Middle1 RGBXA(0x000000, 0.1)
#define kHRYouCardGradient2Middle2 RGBXA(0x400090, 0.1)
#define kHRYouCardGradient2End RGBXA(0x3baedb, 0.7)

#define kHRYouCardGradient3 RGBXA(0x000000, 0.3)

@interface ViewController() <
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = kHRStreamDefaultBackgroundColor;

    [self setUpCoverBackgroundWithGradient];
    [self setUpCollectionView];
}

- (void)setUpCoverBackgroundWithGradient
{
    _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"https://s3.yimg.com/lo/api/res/1.2/qMeNAR2txud7f_fqWnYu8w--/YXBwaWQ9dHdhYnVuZXdz/https://s3.yimg.com/bt/api/res/1.2/aqsWny0wwgaRkiSX1qd3XQ--/YXBwaWQ9eW5ld3NfbGVnbztxPTg1O3c9NDUw/http://media.zenfs.com/zh-Hant_TW/News/YahooOmg/20160905160346_tw_omg_news_863353.jpg"] placeholderImage:nil options:SDWebImageRefreshCached];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient1Start, kHRYouCardGradient1End] gradientType:kHRGraphicsFactoryGradientTypeBottomLeftToUpperRight points:@[@0, @0.6] size:self.view.frame.size] atIndex:2];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient2Start, kHRYouCardGradient2Middle1, kHRYouCardGradient2Middle2, kHRYouCardGradient2End] gradientType:kHRGraphicsFactoryGradientTypeVertical points:@[@0, @0.3, @0.5, @0.9] size:self.view.frame.size] atIndex:1];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient3, kHRYouCardGradient3] gradientType:kHRGraphicsFactoryGradientTypeVertical points:nil size:self.view.frame.size] atIndex:0];

    [self.view addSubview:_imageView];
}

- (void)setUpCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumInteritemSpacing = 0.f;
    layout.minimumLineSpacing = 0.f;
    layout.itemSize = self.view.frame.size;

    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled = YES;
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    

    [_collectionView registerClass:[HRScrollableCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardCoverCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardCoverCell nibName]];
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardStoryCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardStoryCell nibName]];
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardQuoteCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardQuoteCell nibName]];
    
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

    HRYouCardCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardCoverCell nibName] forIndexPath:indexPath];
    }
    else if (indexPath.row == 1) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardStoryCell nibName] forIndexPath:indexPath];
    }
    else if (indexPath.row == 2) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardQuoteCell nibName] forIndexPath:indexPath];
    }
    [cell populateWithDataSourceItem:nil forSize:self.collectionView.frame.size];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will display cell %tu\n", indexPath.row);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.frame.size;
}

@end
