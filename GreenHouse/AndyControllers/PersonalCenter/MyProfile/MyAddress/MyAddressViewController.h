//
//  MyAddressViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@class MyAddressModel;
@protocol MyAddressViewControllerDelegate <NSObject>
- (void)sendBackAddress:(MyAddressModel*)addressModel;
@end
@interface MyAddressViewController : BaseViewController
@property(nonatomic,weak)id<MyAddressViewControllerDelegate>MyAddressViewControllerDelegate;
@property(nonatomic,assign)BOOL isNeedBack;
@property(nonatomic,assign)BOOL isDingdian;
@end
