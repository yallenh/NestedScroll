//
//  NSString+HRSSSize.h
//  NestedScroll
//
//  Created by Allen on 9/16/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HRSSSize)

- (CGSize)hrss_sizeWithFont:(UIFont *)font;
- (CGSize)hrss_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
