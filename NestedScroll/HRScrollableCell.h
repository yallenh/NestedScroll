//
//  HRScrollableCell.h
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/8/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRScrollableCell : UICollectionViewCell

@property (nonatomic) NSUInteger idx;
- (void)populateData:(id)data;
- (CGFloat)contentHeight;
- (CGFloat)contentOffsetY;

@end
