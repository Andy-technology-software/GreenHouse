//
//  ICManagementTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/28.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICManagementModel;
@interface ICManagementTableViewCell : UITableViewCell
- (void)configCellWithModel:(ICManagementModel *)model;

@end
