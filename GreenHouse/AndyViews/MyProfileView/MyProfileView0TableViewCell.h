//
//  MyProfileView0TableViewCell.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyProfile0Model;
@protocol MyProfileView0TableViewCellDelegate <NSObject>
- (void)personInfo;
@end
@interface MyProfileView0TableViewCell : UITableViewCell
- (void)configCellWithModel:(MyProfile0Model *)model;
@property(nonatomic,weak)id<MyProfileView0TableViewCellDelegate>MyProfileView0TableViewCellDelegate;
@end
