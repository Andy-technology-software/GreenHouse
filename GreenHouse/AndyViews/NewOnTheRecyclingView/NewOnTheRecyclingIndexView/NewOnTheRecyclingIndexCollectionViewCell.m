//
//  NewOnTheRecyclingIndexCollectionViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/7/22.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "NewOnTheRecyclingIndexCollectionViewCell.h"

@implementation NewOnTheRecyclingIndexCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20)];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame), 20)];
        self.text.font = [UIFont systemFontOfSize:12];
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
