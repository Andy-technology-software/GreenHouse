//
//  AppointmentExchange2TableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentExchange2Model;
@protocol AppointmentExchange2TableViewCellDelegate <NSObject>
- (void)sendBackBeizhu:(NSString*)beizhu;

@end
@interface AppointmentExchange2TableViewCell : UITableViewCell
- (void)configCellWithModel:(AppointmentExchange2Model *)model;
@property(nonatomic,weak)id<AppointmentExchange2TableViewCellDelegate>AppointmentExchange2TableViewCellDelegate;

@end
