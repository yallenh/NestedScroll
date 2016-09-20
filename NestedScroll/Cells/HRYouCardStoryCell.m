//
//  HRYouCardStoryCell.m
//  NestedScroll
//
//  Created by Allen on 9/19/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardStoryCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HRYouCardStoryCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *providerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *providerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *provider;

@end

@implementation HRYouCardStoryCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.subTitle.text = nil;
    self.subTitle.font = [UIFont systemFontOfSize:subTitleFontSize];
    self.desc.text = nil;
    self.desc.font = [UIFont systemFontOfSize:descFontSize];
    self.provider.text = nil;
    self.provider.font = [UIFont systemFontOfSize:subProviderFontSize];

    [self setUpCoverImageView:self.cover];
    [self setUpProviderView:self.providerView];
}

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size;
{
    // [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    NSString *title = @"《熔爐》（2011）";
    NSString *desc = @"正義教師揭弊校園黑暗死角的孔劉！《熔爐》是一部以校園黑暗面為題的電影，孔劉在片中飾演勇於揭開真相的美術老師，演出深刻發人深省！1正義教師揭弊校園黑暗死角的孔劉！《熔爐》是一部以校園黑暗面為題的電影，孔劉在片中飾演勇於揭開真相的美術老師，演出深刻發人深省！2正義教師揭弊校園黑暗死角的孔劉！《熔爐》是一部以校園黑暗面為題的電影，孔劉在片中飾演勇於揭開真相的美術老師，演出深刻發人深省！3正義教師揭弊校園黑暗死角的孔劉！《熔爐》是一部以校園黑暗面為題的電影，孔劉在片中飾演勇於揭開真相的美術老師，演出深刻發人深省！4正義教師揭弊校園黑暗死角的孔劉！《熔爐》是一部以校園黑暗面為題的電影，孔劉在片中飾演勇於揭開真相的美術老師，演出深刻發人深省！5正義教師揭弊校園黑暗死角的孔劉！《熔爐》是一部以校園黑暗面為題的電影，孔劉在片中飾演勇於揭開真相的美術老師，演出深刻發人深省！6正義教師揭弊校園黑暗死角的孔劉！《熔爐》是一部以校園黑暗面為題的電影，孔劉在片中飾演勇於揭開真相的美術老師，演出深刻發人深省！7";
    NSString *provider = @"蘋果日報蘋果日報";
    
    [self.cover sd_setImageWithURL:[NSURL URLWithString:@"https://i1.kknews.cc/large/5678/5352774826"] placeholderImage:nil options:SDWebImageRefreshCached];

    self.subTitle.text = title;
    self.subTitleHeightConstraint.constant = [self heightForLabelText:self.subTitle.text fontSize:subTitleFontSize];

    self.desc.text = desc;
    self.descHeightConstraint.constant = [self heightForLabelText:self.desc.text fontSize:descFontSize];

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
