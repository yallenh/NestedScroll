//
//  HRYouCardCoverView.m
//  NestedScroll
//
//  Created by Allen on 9/16/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardCoverView.h"

@interface HRYouCardCoverView ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descCenterYConstraint;

@property (weak, nonatomic) IBOutlet UILabel *provider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *providerHeightConstraint;
@end

@implementation HRYouCardCoverView

- (void)awakeFromNib
{
    self.title.text = nil;
    self.title.font = [UIFont systemFontOfSize:titleFontSize];
    self.desc.text = nil;
    self.desc.font = [UIFont systemFontOfSize:descFontSize];
    self.provider.text = nil;
    self.provider.font = [UIFont systemFontOfSize:providerFontSize];
}

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size;
{
    NSString *title = @"全台五大深夜咖啡廳";
    NSString *desc = @"如果你半夜肚子餓想念深夜食堂，想來一杯可能會令你更睡不著的咖啡， 但五月天的名氣藏不住。";
    NSString *provider = @"圖片來源：蘋果日報";
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;

    self.title.text = title;
    self.titleHeightConstraint.constant = [self heightForLabelText:self.title.text fontSize:titleFontSize];

    self.desc.text = desc;
    self.descHeightConstraint.constant = [self heightForLabelText:self.desc.text fontSize:descFontSize];

    self.provider.text = provider;
    self.providerHeightConstraint.constant = [self heightForLabelText:self.provider.text fontSize:providerFontSize];

    self.descCenterYConstraint.constant = ((self.titleHeightConstraint.constant - titleFontSize * lineHeightFactor) - (self.providerHeightConstraint.constant - providerFontSize * lineHeightFactor)) / 2.f;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
