//
//  HRYouCardViewController.m
//  NestedScroll
//
//  Created by Allen on 9/20/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardViewController.h"

// cells
#import "HRYouCardCoverCell.h"
#import "HRYouCardStoryCell.h"
#import "HRYouCardQuoteCell.h"
#import "HRYouCardBulletPointCell.h"

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

#define kHRYouCardHeaderGradientStart RGBXA(0x00ada9, 0.9)
#define kHRYouCardHeaderGradientEnd RGBXA(0x73209e, 0.9)

@interface HRYouCardViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *headerBackButton;
@property (weak, nonatomic) IBOutlet UIButton *headerSaveButton;
@property (weak, nonatomic) IBOutlet UIButton *headerLikeButton;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UILabel *headerSource;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) UIImageView *imageView;

@end

@implementation HRYouCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = kHRStreamDefaultBackgroundColor;

    [self setUpHeader];
    [self setUpCoverBackgroundWithGradient];
    [self setUpCollectionView];
}

- (void)setUpHeader
{
    [self.headerView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardHeaderGradientStart, kHRYouCardHeaderGradientEnd] gradientType:kHRGraphicsFactoryGradientTypeHorizontal points:nil size:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(_headerView.frame))] atIndex:0];

    UIImageView *saveIcon= self.headerSaveButton.imageView;
    saveIcon.image = [saveIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    saveIcon.tintColor = [UIColor whiteColor];
    [self.headerSaveButton setImage:saveIcon.image forState:UIControlStateNormal];
}

- (void)setUpCoverBackgroundWithGradient
{
    _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"https://s3.yimg.com/lo/api/res/1.2/qMeNAR2txud7f_fqWnYu8w--/YXBwaWQ9dHdhYnVuZXdz/https://s3.yimg.com/bt/api/res/1.2/aqsWny0wwgaRkiSX1qd3XQ--/YXBwaWQ9eW5ld3NfbGVnbztxPTg1O3c9NDUw/http://media.zenfs.com/zh-Hant_TW/News/YahooOmg/20160905160346_tw_omg_news_863353.jpg"] placeholderImage:nil options:SDWebImageRefreshCached];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient1Start, kHRYouCardGradient1End] gradientType:kHRGraphicsFactoryGradientTypeBottomLeftToUpperRight points:@[@0, @0.6] size:self.view.frame.size] atIndex:2];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient2Start, kHRYouCardGradient2Middle1, kHRYouCardGradient2Middle2, kHRYouCardGradient2End] gradientType:kHRGraphicsFactoryGradientTypeVertical points:@[@0, @0.3, @0.5, @0.9] size:self.view.frame.size] atIndex:1];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient3, kHRYouCardGradient3] gradientType:kHRGraphicsFactoryGradientTypeVertical points:nil size:self.view.frame.size] atIndex:0];
}

- (void)setUpCollectionView
{
    _collectionView.backgroundView = _imageView;
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardCoverCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardCoverCell nibName]];
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardStoryCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardStoryCell nibName]];
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardQuoteCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardQuoteCell nibName]];
    [_collectionView registerNib:[UINib nibWithNibName:[HRYouCardBulletPointCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardBulletPointCell nibName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UI handler
- (IBAction)didTapBackButton:(id)sender {
}

- (IBAction)didTapSaveButton:(id)sender {
}

- (IBAction)didTapLikeButton:(id)sender {
}



#pragma mark collection view delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
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
    else if (indexPath.row == 3) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardBulletPointCell nibName] forIndexPath:indexPath];
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
