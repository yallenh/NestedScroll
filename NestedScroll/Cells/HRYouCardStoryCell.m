//
//  HRYouCardStoryCell.m
//  NestedScroll
//
//  Created by Allen on 9/19/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardStoryCell.h"
#import "ATMTriangleView.h"

@interface HRYouCardStoryCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoTopConstraint;
@end

@implementation HRYouCardStoryCell

- (void)awakeFromNib {
    [super awakeFromNib];

    ATMTriangleView *triangle = [[ATMTriangleView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.cover.frame) - triangleHeight, CGRectGetWidth(self.cover.frame), triangleHeight) color:[UIColor whiteColor] orientation:ATMTriangleBottomToRight];
    triangle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.cover addSubview:triangle];
//    _scrollView.canCancelContentTouches = NO;
//    _scrollView.delaysContentTouches = YES;

    self.subTitle.text = nil;
    self.subTitle.font = [UIFont systemFontOfSize:subTitleFontSize];
    self.desc.text = nil;
    self.desc.font = [UIFont systemFontOfSize:descFontSize];
}

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size;
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    NSString *title = @"睡不著的好去處！全台五大深夜咖啡廳";//1睡不著的好去處！全台五大深夜咖啡廳2睡不著的好去處！全台五大深夜咖啡廳3";
    NSString *desc = @"暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。";//1暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。2暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。3暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。4暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。5暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。6暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。7暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。8暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。9暗角咖啡在台北市算是小有名氣的暗角咖啡，凌晨四點才結束營業的特點，著實讓許多夜貓子或夜間工作者找到了個好去處。10";

    self.subTitle.text = title;
    self.subTitleHeightConstraint.constant = [self heightForLabelText:self.subTitle.text fontSize:subTitleFontSize];

    self.desc.text = desc;
    self.descHeightConstraint.constant = [self heightForLabelText:self.desc.text fontSize:descFontSize];

    [self setNeedsLayout];
    [self layoutIfNeeded];

    CGFloat diff = CGRectGetHeight(self.scrollView.frame) - CGRectGetHeight(self.scrollContentView.frame);
    if (diff > 0) {
        self.infoTopConstraint.constant = infoTop + diff;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (IBAction)didTapInfoButton:(id)sender {
}

@end
