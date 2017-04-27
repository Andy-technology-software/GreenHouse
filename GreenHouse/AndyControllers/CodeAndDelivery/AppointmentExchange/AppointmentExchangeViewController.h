//
//  AppointmentExchangeViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@class AppointmentExchange0Model;
@interface AppointmentExchangeViewController : BaseViewController
@property(nonatomic,copy)NSString* presentId;
@property(nonatomic,copy)NSString* presentName;
@property(nonatomic,copy)NSString* goodsid;
//图片地址
@property(nonatomic,copy)NSString* thumb;
@property(nonatomic,copy)NSString* needJifen;
@property(nonatomic,retain)AppointmentExchange0Model* s0Model;
@end
