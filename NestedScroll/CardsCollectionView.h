//
//  CardsCollectionView.h
//  NestedScroll
//
//  Created by Yan-Hsiang Huang on 8/4/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface CardsCollectionView : UICollectionView

@property (nonatomic) ScrollDirection scrollDirection;

- (void)scrollOneStep:(ScrollDirection)scrollDirection;

@end
