//
//  HRYouCardViewProtocol.h
//  NestedScroll
//
//  Created by Allen on 9/16/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

@protocol HRYouCardViewDelegate <NSObject>

@optional

- (void)viewDidWantToPresentLightBoxWithViewController:(UIViewController *)viewContorller senderView:(UIView *)sender;
- (void)viewDidWantToShowActionSheet;

@end



@protocol HRYouCardViewProtocol <NSObject>

@property (nonatomic, weak) id<HRYouCardViewDelegate> cardViewDelegate;

+ (UIView<HRYouCardViewProtocol>*)cardView;

@optional

- (void)populateWithDataSourceItem:(id)item forSize:(CGSize)size;
- (CGFloat)heightForLabelText:(NSString *)text fontSize:(CGFloat)fontSize;

@end