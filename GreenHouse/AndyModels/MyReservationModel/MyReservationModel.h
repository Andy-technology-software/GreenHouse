//
//  MyReservationModel.h
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyReservationModel : NSObject
@property(nonatomic,copy)NSString* headImageStr;
@property(nonatomic,copy)NSString* titleNameStr;
@property(nonatomic,copy)NSString* addressStr;
@property(nonatomic,copy)NSString* timeStr;
@property(nonatomic,copy)NSString* jifenStr;
@property(nonatomic,copy)NSString* yuyueTypeStr;
@property(nonatomic,copy)NSString* goodsid;
@property(nonatomic,copy)NSString* orderid;
@property(nonatomic,assign)NSInteger typeInt;
@end
