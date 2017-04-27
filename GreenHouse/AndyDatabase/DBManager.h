//
//  DBManager.h
//  E展会
//
//  Created by 徐仁强 on 15/8/28.
//  Copyright (c) 2015年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginDataBaseModel.h"

@interface DBManager : NSObject

+(DBManager*)shareManager;
-(void)insertLoginModel:(LoginDataBaseModel *)model;
-(NSMutableArray*)getAllLoginModel;
- (void)deleteLoginData;
-(void)upDataHeadImage:(NSString*)str1 other:(NSString*)str2;
-(void)upNickName:(NSString*)str1 other:(NSString*)str2;
-(void)upYaoqingma:(NSString*)str1 other:(NSString*)str2;
@end
