//
//  CHMenuView.h
//  CHCourselView
//
//  Created by chenghao on 2017/2/28.
//  Copyright © 2017年 clearcdm.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHMenuView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles andViews:(NSArray*)views andTitleColor:(UIColor*)color;
@end
