//
//  HRYouCardBulletPointCell.m
//  NestedScroll
//
//  Created by Allen on 9/20/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardBulletPointCell.h"
#import "HRYouCardBulletPointItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HRYouCardBulletPointCell ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverBottomConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *coverIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverIconBottonConstraint;


@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleHeightConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *list;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *providerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *providerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *provider;

@property (nonatomic) NSMutableArray *itemsText;
@property (nonatomic) NSMutableArray *itemsHeight;

@end

@implementation HRYouCardBulletPointCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.subTitle.text = nil;
    self.subTitle.font = [UIFont systemFontOfSize:subTitleFontSize];
    self.provider.text = nil;
    self.provider.font = [UIFont systemFontOfSize:subProviderFontSize];

    [self setUpCoverImageView:self.cover];
    [self setUpProviderView:self.providerView];
    [self setUpCollectionView];
}

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size
{
    NSString *title = @"睡不著的好去處！全台五大深夜咖啡廳";
    NSString *provider = @"蘋果日報";
    NSString *coverURL = @"https://i1.kknews.cc/large/5678/5352774826";

    if (coverURL) {
        self.cover.hidden = NO;
        [self.cover sd_setImageWithURL:[NSURL URLWithString:coverURL] placeholderImage:nil options:SDWebImageRefreshCached];
        self.coverBottomConstraint.priority = UILayoutPriorityDefaultHigh;
        self.coverIcon.hidden = YES;
        self.coverIconBottonConstraint.priority = UILayoutPriorityDefaultLow;
        self.scrollContentView.backgroundColor = [UIColor whiteColor];
    }
    else {
        self.cover.hidden = YES;
        self.coverBottomConstraint.priority = UILayoutPriorityDefaultLow;
        self.coverIcon.hidden = NO;
        self.coverIconBottonConstraint.priority = UILayoutPriorityDefaultHigh;
        self.scrollContentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"youcard-list-bg"]];
    }
    

    self.subTitle.text = title;
    self.subTitleHeightConstraint.constant = [self heightForLabelText:self.subTitle.text fontSize:subTitleFontSize];

    self.provider.text = provider;
    self.providerViewWidthConstraint.constant = providerViewDefaultWidth + [self widthForLabelText:provider fontSize:subProviderFontSize];

    self.itemsHeight = [NSMutableArray array];
    self.itemsText = [NSMutableArray arrayWithArray:
    @[
      @"暗角咖啡",
      @"離線咖啡1離線咖啡2離線咖啡3離線咖啡4離線咖啡5離線咖啡6離線咖啡7離線咖啡8",
      @"Sugar Man Cafe",
      @"Kuantum Kafe",
      @"早秋咖啡 CAFE Macho1早秋咖啡 CAFE Macho2早秋咖啡 CAFE Macho3",
      @"暗角咖啡",
      @"離線咖啡1離線咖啡2離線咖啡3離線咖啡4離線咖啡5離線咖啡6離線咖啡7離線咖啡8",
      @"Sugar Man Cafe",
      @"Kuantum Kafe",
      @"早秋咖啡 CAFE Macho1早秋咖啡 CAFE Macho2早秋咖啡 CAFE Macho3"
      ]];

    __block CGFloat listHeight = 0;
    __weak typeof (self) weakSelf = self;
    [self.itemsText enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL *stop) {
        typeof (weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            *stop = YES;
            return;
        }
        CGFloat itemHeight = [strongSelf heightForLabelText:item fontSize:bulletPointTitleFontSize];
        listHeight += itemHeight;
        [strongSelf.itemsHeight addObject:[NSNumber numberWithDouble:itemHeight]];
    }];
    self.listHeightConstraint.constant = listHeight + fmax(0, [self.itemsHeight count] - 1.f) * bulletPointLineSpacing;

    [self setNeedsLayout];
    [self layoutIfNeeded];

    [self resizeScrollView];
}

- (void)resizeScrollView
{
    CGFloat diff = CGRectGetHeight(self.scrollView.frame) - CGRectGetHeight(self.scrollContentView.frame);
    if (diff > 0) {
        self.infoTopConstraint.constant = infoTop + diff;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (IBAction)didTapInfoButton:(id)sender {
    self.providerView.hidden = !self.providerView.hidden;
}

- (void)setUpCollectionView
{
    _list.backgroundColor = [UIColor clearColor];
    _list.delegate = self;
    _list.dataSource = self;
    [_list registerNib:[UINib nibWithNibName:[HRYouCardBulletPointItem nibName] bundle:nil] forCellWithReuseIdentifier:[HRYouCardBulletPointItem nibName]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.itemsHeight count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRYouCardBulletPointItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:[HRYouCardBulletPointItem nibName] forIndexPath:indexPath];
    item.text = [self.itemsText objectAtIndex:indexPath.row];
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), [[self.itemsHeight objectAtIndex:indexPath.row] doubleValue]);
}

@end
