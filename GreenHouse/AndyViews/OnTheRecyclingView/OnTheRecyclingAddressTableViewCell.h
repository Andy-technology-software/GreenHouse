//
//  OnTheRecyclingAddressTableViewCell.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/7/18.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OnTheRecyclingAddModel;
@protocol OnTheRecyclingAddressTableViewCellDelegate <NSObject>
- (void)sendBackSeleAddress;
@end
@interface OnTheRecyclingAddressTableViewCell : UITableViewCell
- (void)configCellWithModel:(OnTheRecyclingAddModel *)model;
@property(nonatomic,weak)id<OnTheRecyclingAddressTableViewCellDelegate>OnTheRecyclingAddressTableViewCellDelegate;

@end
