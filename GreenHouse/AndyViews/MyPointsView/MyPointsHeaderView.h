//
//  MyPointsHeaderView.h
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyPointsHeadModel;
@interface MyPointsHeaderView : UITableViewHeaderFooterView
- (void)makeHeader:(MyPointsHeadModel*)model;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
