//
//  AppointmentDetailsTableViewCell.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentDetailsModel;
@interface AppointmentDetailsTableViewCell : UITableViewCell
- (void)configCellWithModel:(AppointmentDetailsModel *)model;

@end
