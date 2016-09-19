//
//  HRYouCardCoverCell.m
//  NestedScroll
//
//  Created by Allen on 9/19/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRYouCardCoverCell.h"

@interface HRYouCardCoverCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descCenterYConstraint;

@property (weak, nonatomic) IBOutlet UILabel *provider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *providerHeightConstraint;
@end

@implementation HRYouCardCoverCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor clearColor];
    self.title.text = nil;
    self.title.font = [UIFont systemFontOfSize:titleFontSize];
    self.desc.text = nil;
    self.desc.font = [UIFont systemFontOfSize:descFontSize];
    self.provider.text = nil;
    self.provider.font = [UIFont systemFontOfSize:providerFontSize];
}

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size;
{
    NSString *title = @"給你更多屍速列車的帥爸！七種孔劉一次擁有";
    NSString *desc = @"全台票話題口碑延燒的《屍速列車》，讓所有觀眾都愛上了片中奮不顧身救女兒的帥爸爸孔劉。一個怎夠看？送上六部電影裡的七種孔劉Look，眼睛睜大就是你的！";
    NSString *provider = @"圖片來源：車庫娛樂";

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
