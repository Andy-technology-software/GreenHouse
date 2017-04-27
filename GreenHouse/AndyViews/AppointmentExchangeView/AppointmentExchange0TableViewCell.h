//
//  AppointmentExchange0TableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentExchange0Model;
@protocol AppointmentExchange0TableViewCellDelegate <NSObject>
- (void)dingdian;
- (void)songhuo;

@end
@interface AppointmentExchange0TableViewCell : UITableViewCell
- (void)configCellWithModel:(AppointmentExchange0Model *)model;
@property(nonatomic,weak)id<AppointmentExchange0TableViewCellDelegate>AppointmentExchange0TableViewCellDelegate;

@end
