//
//  AddCommonlyUsedAddressHeadrView.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCommonlyUsedAddressHeaderModel;

@interface AddCommonlyUsedAddressHeadrView : UITableViewHeaderFooterView
- (void)makeHeader:(AddCommonlyUsedAddressHeaderModel* )model;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
