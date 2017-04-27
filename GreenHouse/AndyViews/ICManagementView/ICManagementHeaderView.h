//
//  ICManagementHeaderView.h
//  AndyCoder
//
//  Created by lingnet on 16/4/28.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICCardHeaderModel;
@interface ICManagementHeaderView : UITableViewHeaderFooterView
- (void)makeHeader:(ICCardHeaderModel*)model;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
