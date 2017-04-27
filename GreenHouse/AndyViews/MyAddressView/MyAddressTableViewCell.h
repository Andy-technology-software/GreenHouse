//
//  MyAddressTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyAddressModel;
@interface MyAddressTableViewCell : UITableViewCell
- (void)configCellWithModel:(MyAddressModel *)model;
@end
