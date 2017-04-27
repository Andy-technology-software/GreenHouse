//
//  ResubmitViewController.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@protocol ResubmitViewControllerDelegate <NSObject>
- (void)sendBackIsSendSuccess:(BOOL)isSuccess;
@end
@interface ResubmitViewController : BaseViewController
//订单id
@property(nonatomic,copy)NSString* presentId;
//
@property(nonatomic,copy)NSString* remark;
//图片地址
@property(nonatomic,copy)NSString* thumb;
@property(nonatomic,weak)id<ResubmitViewControllerDelegate>ResubmitViewControllerDelegate;

@end
