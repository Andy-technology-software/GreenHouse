//
//  AppointmentDetailsViewController.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@protocol AppointmentDetailsViewControllerDelegate <NSObject>
- (void)sendBackDeleteIndex:(NSInteger)deleteIndex;
- (void)sendBackNeedRefresh:(BOOL)isNeedRefresh;
@end
@interface AppointmentDetailsViewController : BaseViewController
//订单id
@property(nonatomic,copy)NSString* presentId;
//礼品id
@property(nonatomic,copy)NSString* goodsId;
//
@property(nonatomic,copy)NSString* remark;

@property(nonatomic,assign)NSInteger deleteIndex;

//标记来自哪里
@property(nonatomic,assign)NSInteger typeInt;//1来自带兑换   2来自已兑换

@property(nonatomic,weak)id<AppointmentDetailsViewControllerDelegate>AppointmentDetailsViewControllerDelegate;

@end
