//
//  CHMenuCollectionViewCell.m
//  CHCourselView
//
//  Created by chenghao on 2017/2/28.
//  Copyright © 2017年 clearcdm.com. All rights reserved.
//

#import "CHMenuCollectionViewCell.h"

@implementation CHMenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height-5)];
        self.title.textColor = [UIColor darkGrayColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
        
    }
    
    return self;
    
}

@end
