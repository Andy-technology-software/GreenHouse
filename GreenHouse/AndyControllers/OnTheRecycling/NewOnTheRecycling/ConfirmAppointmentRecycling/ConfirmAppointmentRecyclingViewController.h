//
//  ConfirmAppointmentRecyclingViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@protocol ConfirmAppointmentRecyclingViewControllerDelegate <NSObject>
- (void)sendBackYuyueIdStr:(NSString* )idStr;

@end
@interface ConfirmAppointmentRecyclingViewController : BaseViewController
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,weak)id<ConfirmAppointmentRecyclingViewControllerDelegate>ConfirmAppointmentRecyclingViewControllerDelegate;

@end
