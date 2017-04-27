//
//  AppointmentToRecycleTableViewCell.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/5.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentToRecycleModel;
@interface AppointmentToRecycleTableViewCell : UITableViewCell
- (void)configCellWithModel:(AppointmentToRecycleModel *)model;

@end
