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
#import "HRYouCardNavPoint.h"

// utils
#import "HRGraphicsFactory.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MNColorKit/MNColorKit.h>

// header
#define kHRYouCardHeaderGradientStart RGBXA(0x00ada9, 0.9)
#define kHRYouCardHeaderGradientEnd RGBXA(0x73209e, 0.9)

// cards
#define kHRStreamDefaultBackgroundColor RGBX(0xe0e0e7)
#define kHRYouCardGradient1Start RGBXA(0x30d3b6, 1.f)
#define kHRYouCardGradient1End RGBXA(0x30d3b6, 0)
#define kHRYouCardGradient2Start RGBXA(0x000000, 0.7)
#define kHRYouCardGradient2Middle1 RGBXA(0x000000, 0.1)
#define kHRYouCardGradient2Middle2 RGBXA(0x400090, 0.1)
#define kHRYouCardGradient2End RGBXA(0x3baedb, 0.7)
#define kHRYouCardGradient3 RGBXA(0x000000, 0.3)

// navbar
#define kHRYouCardNavbarGradientStart RGBXA(0x1db2BB, 1.f)
#define kHRYouCardNavbarGradientEnd RGBXA(0x1db2e8, 1.f)

@interface HRYouCardViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
// UI
@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIButton *headerBackButton;
@property (weak, nonatomic) IBOutlet UIButton *headerSaveButton;
@property (weak, nonatomic) IBOutlet UIButton *headerLikeButton;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UILabel *headerSource;

@property (weak, nonatomic) IBOutlet UICollectionView *cards;

@property (weak, nonatomic) IBOutlet UICollectionView *navbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navbarHeightConstraint;

@property (nonatomic) UIImageView *imageView;

// data
@property (nonatomic) NSArray *dataSourceItems;
@property (nonatomic) NSMutableArray *cardsState;
@property (nonatomic) NSUInteger currentIndex;
@end

@implementation HRYouCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = kHRStreamDefaultBackgroundColor;

    [self setUpHeader];
    [self setUpNavbar];
    [self setUpCollectionView];

    self.dataSourceItems = @[@{}, @{}, @{}];
}

- (void)setUpHeader
{
    [self.header.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardHeaderGradientStart, kHRYouCardHeaderGradientEnd] gradientType:kHRGraphicsFactoryGradientTypeHorizontal points:nil size:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.header.frame))] atIndex:0];

    UIImageView *saveIcon= self.headerSaveButton.imageView;
    saveIcon.image = [saveIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    saveIcon.tintColor = [UIColor whiteColor];
    [self.headerSaveButton setImage:saveIcon.image forState:UIControlStateNormal];
}

- (void)setUpCollectionView
{
    // collection view
    [self.cards registerNib:[UINib nibWithNibName:[HRYouCardCoverCell nibName] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HRYouCardCoverCell nibName]];
    [self.cards registerNib:[UINib nibWithNibName:[HRYouCardStoryCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardStoryCell nibName]];
    [self.cards registerNib:[UINib nibWithNibName:[HRYouCardQuoteCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardQuoteCell nibName]];
    [self.cards registerNib:[UINib nibWithNibName:[HRYouCardBulletPointCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardBulletPointCell nibName]];
    
    // background view
    _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"https://s3.yimg.com/lo/api/res/1.2/qMeNAR2txud7f_fqWnYu8w--/YXBwaWQ9dHdhYnVuZXdz/https://s3.yimg.com/bt/api/res/1.2/aqsWny0wwgaRkiSX1qd3XQ--/YXBwaWQ9eW5ld3NfbGVnbztxPTg1O3c9NDUw/http://media.zenfs.com/zh-Hant_TW/News/YahooOmg/20160905160346_tw_omg_news_863353.jpg"] placeholderImage:nil options:SDWebImageRefreshCached];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient1Start, kHRYouCardGradient1End] gradientType:kHRGraphicsFactoryGradientTypeBottomLeftToUpperRight points:@[@0, @0.6] size:self.view.frame.size] atIndex:2];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient2Start, kHRYouCardGradient2Middle1, kHRYouCardGradient2Middle2, kHRYouCardGradient2End] gradientType:kHRGraphicsFactoryGradientTypeVertical points:@[@0, @0.3, @0.5, @0.9] size:self.view.frame.size] atIndex:1];
    [_imageView.layer insertSublayer:[[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardGradient3, kHRYouCardGradient3] gradientType:kHRGraphicsFactoryGradientTypeVertical points:nil size:self.view.frame.size] atIndex:0];
    self.cards.backgroundView = _imageView;
}

- (void)setUpNavbar
{
    self.navbar.backgroundColor = [UIColor clearColor];
    [self.navbar registerClass:[HRYouCardNavPoint class] forCellWithReuseIdentifier:[HRYouCardNavPoint cellName]];
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

#pragma mark Setter

- (void)setDataSourceItems:(NSArray *)dataSourceItems
{
    _dataSourceItems = dataSourceItems;
    _cardsState = [NSMutableArray array];
    __weak typeof (self) weakSelf = self;
    [_dataSourceItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [weakSelf.cardsState addObject:[NSNumber numberWithBool:idx ? NO : YES]];
    }];

    // resize navbar
    NSUInteger count = [self.dataSourceItems count];
    self.navbarHeightConstraint.constant = count * navBarPointSize + (count ? count - 1 : 0) * navBarCellSpacing + 2 * navBarSectionSpacing;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    // navbar background view
    UIView *navbarBg = [[UIView alloc] initWithFrame:self.navbar.frame];
    CAGradientLayer *layer = [[HRGraphicsFactory sharedFactory] generateGradientLayerWithColors:@[kHRYouCardNavbarGradientStart, kHRYouCardNavbarGradientEnd] gradientType:kHRGraphicsFactoryGradientTypeVertical points:nil size:navbarBg.frame.size];
    layer.cornerRadius = CGRectGetWidth(navbarBg.frame) / 2.f;
    layer.borderWidth = navBarLineWidth;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.opacity = navBarOpacity;
    [navbarBg.layer addSublayer:layer];
    self.navbar.backgroundView = navbarBg;
    self.navbar.hidden = YES;
    
    // init current index
    _currentIndex = 0;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    if (_currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        if ([_cardsState count] > currentIndex) {
            [self.cardsState replaceObjectAtIndex:currentIndex withObject:@YES];
            [self.navbar reloadData];
        }
    }
}



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
    return [self.dataSourceItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.cards) {
        HRYouCardCell *cell = nil;
        if (indexPath.row == 0) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardStoryCell nibName] forIndexPath:indexPath];
        }
        else if (indexPath.row == 1) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardQuoteCell nibName] forIndexPath:indexPath];
        }
        else if (indexPath.row == 2) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardBulletPointCell nibName] forIndexPath:indexPath];
        }
        [cell populateWithDataSourceItem:nil forSize:self.cards.frame.size];
        return cell;
    }
    else if (collectionView == self.navbar) {
        HRYouCardNavPoint *point = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardNavPoint cellName] forIndexPath:indexPath];
        if (indexPath.row == self.currentIndex) {
            point.state = HRYouCardNavPointStateVisiting;
        }
        else if ([[self.cardsState objectAtIndex:indexPath.row] boolValue]) {
            point.state = HRYouCardNavPointStateVisited;
        }
        else {
            point.state = HRYouCardNavPointStateToBeVisit;
        }
        return point;
    }

    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.cards) {
        return self.cards.frame.size;
    }
    else if (collectionView == self.navbar) {
        return CGSizeMake(navBarPointSize, navBarPointSize);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView == self.cards) {
        return self.cards.frame.size;
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.cards && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HRYouCardCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[HRYouCardCoverCell nibName] forIndexPath:indexPath];
        [cell populateWithDataSourceItem:nil forSize:self.cards.frame.size];
        return cell;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.cards) {
        CGFloat height = CGRectGetHeight(self.cards.frame);
        NSUInteger index = ((self.cards.contentOffset.y - height / 2.f) / height) + 1;
        if (!index) {
            self.navbar.hidden = YES;
        }
        else {
            self.currentIndex = index - 1;
            self.navbar.hidden = NO;
        }
    }
}

@end
