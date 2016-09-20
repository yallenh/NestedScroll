//
//  HRYouCardQuoteCell.m
//  NestedScroll
//
//  Created by Allen on 9/20/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardQuoteCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HRYouCardQuoteCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UIView *thumbnailContainer;

@property (weak, nonatomic) IBOutlet UILabel *quote;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quoteHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *providerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *providerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *provider;

@end

@implementation HRYouCardQuoteCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.quote.text = nil;
    self.quote.font = [UIFont systemFontOfSize:subTitleFontSize];
    self.source.text = nil;
    self.source.font = [UIFont systemFontOfSize:descFontSize];

    self.provider.text = nil;
    self.provider.font = [UIFont systemFontOfSize:subProviderFontSize];

    if ([UIImageView instancesRespondToSelector:@selector(setMaskView:)]) {
        UIImage *maskImage = [UIImage imageNamed:@"comments_avatar_default_bg"];
        UIImageView *thumbnailMask = [[UIImageView alloc] initWithImage:maskImage];
        thumbnailMask.frame = self.thumbnail.bounds;
        self.thumbnail.maskView = thumbnailMask;
        UIImageView *thumbnailContainermask = [[UIImageView alloc] initWithImage:maskImage];
        thumbnailContainermask.frame = self.thumbnailContainer.bounds;
        self.thumbnailContainer.maskView = thumbnailContainermask;
    }

    [self setUpProviderView:self.providerView];
}

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size;
{
    // [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    NSString *quote = @"“我第一眼看到她的時候，心裡面就有一種很奇怪的感覺。／這個就叫做一見鐘情 OK？”\n\n“每一個人，不管是有時間沒時間，有錢沒有錢，都值得吃一頓好的食物。”\n\n人生是很麻煩啊，但是下一秒，你又會覺得這一切真是他媽的太值得了！”";
    NSString *source = @"《我的蛋男情人》";
    NSString *provider = @"蘋果日報";

    [self.cover sd_setImageWithURL:[NSURL URLWithString:@"https://s2.yimg.com/lo/api/res/1.2/O57B3fIzS.AJKzQno3JpwQ--/YXBwaWQ9dHdhYnVuZXdzO3c9ODAwO2g9NjAwO2ZpPWZpbGw-/https://s.yimg.com/vu/movies/fp/mpho/16/60/71660.jpg"] placeholderImage:nil options:SDWebImageRefreshCached];
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:@"https://s1.yimg.com/lo/api/res/1.2/8bwxEF63WkoT5UxlzzIAUg--/YXBwaWQ9dHdhYnVuZXdzO3c9OTA7aD05MDtmaT1maWxs/https://s.yimg.com/vu/movies/fp/mpho/98/03/69803.jpg"] placeholderImage:nil options:SDWebImageRefreshCached];

    self.quote.text = quote;
    self.quoteHeightConstraint.constant = [self heightForLabelText:self.quote.text fontSize:subTitleFontSize];

    self.source.text = source;
    self.sourceHeightConstraint.constant = [self heightForLabelText:self.source.text fontSize:descFontSize];

    self.provider.text = provider;
    self.providerViewWidthConstraint.constant = providerViewDefaultWidth + [self widthForLabelText:provider fontSize:subProviderFontSize];

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

@end
