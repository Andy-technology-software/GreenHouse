//
//  PersonalCenterTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalCenterModel;
@protocol PersonalCenterTableViewCellDelegate <NSObject>
- (void)personInfo;
@end
@interface PersonalCenterTableViewCell : UITableViewCell
- (void)configCellWithModel:(PersonalCenterModel *)model;
@property(nonatomic,weak)id<PersonalCenterTableViewCellDelegate>PersonalCenterTableViewCellDelegate;
@end
