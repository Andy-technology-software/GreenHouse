//
//  DBManager.h
//  E展会
//
//  Created by 徐仁强 on 16/2/3.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginDataBaseModel : NSObject
@property(nonatomic,copy) NSString* userId;
@property(nonatomic,copy) NSString* password;
@property(nonatomic,copy) NSString* phoneNum;
@property(nonatomic,copy) NSString* nickName;
@property(nonatomic,copy) NSString* userHeadImage;
@property(nonatomic,copy) NSString* myInvateCode;
@property(nonatomic,copy) NSString* recommendPreson;

@end
