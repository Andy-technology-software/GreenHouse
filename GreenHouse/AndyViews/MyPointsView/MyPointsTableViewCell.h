//
//  MyPointsTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyPointsModel;
@interface MyPointsTableViewCell : UITableViewCell
- (void)configCellWithModel:(MyPointsModel *)model;

@end
