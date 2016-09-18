//
//  HRYouCardStoryView.m
//  NestedScroll
//
//  Created by Allen on 9/16/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardStoryView.h"

@interface HRYouCardStoryView ()
@property (weak, nonatomic) IBOutlet UIImageView *cover;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;
@end

@implementation HRYouCardStoryView

- (void)awakeFromNib
{
    self.title.text = nil;
    self.title.font = [UIFont systemFontOfSize:subTitleFontSize];
    self.desc.text = nil;
    self.desc.font = [UIFont systemFontOfSize:descFontSize];
}

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size;
{
    NSString *title = @"睡不著的好去處！全台五大深夜咖啡廳1睡不著的好去處！全台五大深夜咖啡廳2睡不著的好去處！全台五大深夜咖啡廳3";
    NSString *desc = @"暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。1暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。2暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。3暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。4暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。5暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。6暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。7暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。8暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。9暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。10";

    self.title.text = title;
    self.titleHeightConstraint.constant = [self heightForLabelText:self.title.text fontSize:subTitleFontSize];

    self.desc.text = desc;
    self.descHeightConstraint.constant = [self heightForLabelText:self.desc.text fontSize:descFontSize];

    CGRect frame = self.frame;
    frame.size = CGSizeMake(size.width, ceil(fmax([self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height, size.height)));
    self.frame = frame;

    // [self setNeedsLayout];
    // [self layoutIfNeeded];
}

- (IBAction)didTapInfoButton:(id)sender {
}

@end
