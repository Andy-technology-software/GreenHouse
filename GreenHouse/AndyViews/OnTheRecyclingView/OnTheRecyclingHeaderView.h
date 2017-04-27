//
//  OnTheRecyclingHeaderView.h
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OnTheRecyclingHeaderModel;
@interface OnTheRecyclingHeaderView : UITableViewHeaderFooterView
- (void)makeHeader:(OnTheRecyclingHeaderModel*)model;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
