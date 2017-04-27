//
//  DBManager.m
//
//  Created by 徐仁强 on 16/2/3.
//  Copyright © 2016年 徐仁强. All rights reserved.
//
#import "DBManager.h"

#import "FMDatabase.h"
@implementation DBManager{
    FMDatabase*_dataBase;
}
static DBManager *manager = nil;
+ (DBManager *)shareManager{
        @synchronized(self){
        if (manager == nil) {
            manager = [[DBManager alloc] init];
        }
    }
    return manager;
}
- (id)init{
    self = [super init];
    if (self) {
        NSString *dbPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/ezhanhui.db"];
        _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        if ([_dataBase open]) {
            NSString* loginInfoData = @"create table if not exists userLoginInfoData (userId varchar(256),phoneNum varchar(256),nickName varchar(256),userHeadImage varchar(256),myInvateCode varchar(256),recommendPreson varchar(256),password varchar(256))";
                        BOOL isSuccessed =[_dataBase executeUpdate:loginInfoData];
            if (!isSuccessed) {
            }
        }
    }
    return self;
}

- (void)insertLoginModel:(LoginDataBaseModel *)model{
    NSString*insertSql = @"insert into userLoginInfoData(userId,phoneNum,nickName,userHeadImage,myInvateCode,recommendPreson,password) values(?,?,?,?,?,?,?)";
    BOOL isSuccessed=[_dataBase executeUpdate:insertSql,model.userId,model.phoneNum,model.nickName,model.userHeadImage,model.myInvateCode,model.recommendPreson,model.password];
    if(!isSuccessed){
    }
}
- (void)deleteLoginData{
    BOOL isSucceed2=[_dataBase executeUpdate:@"delete from userLoginInfoData"];
    if (isSucceed2) {
    }else{
    }
}
- (NSMutableArray*)getAllLoginModel{
    NSString *selectSql = @"select * from userLoginInfoData";
    FMResultSet *set =[_dataBase executeQuery:selectSql];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        LoginDataBaseModel *model = [[LoginDataBaseModel alloc] init];
        model.userId = [set stringForColumn:@"userId"];
        model.phoneNum = [set stringForColumn:@"phoneNum"];
        model.nickName = [set stringForColumn:@"nickName"];
        model.userHeadImage = [set stringForColumn:@"userHeadImage"];
        model.myInvateCode = [set stringForColumn:@"myInvateCode"];
        model.recommendPreson = [set stringForColumn:@"recommendPreson"];
        model.password = [set stringForColumn:@"password"];
        [array addObject:model];
    }
    return array;
}

-(void)upDataHeadImage:(NSString*)str1 other:(NSString*)str2{
    BOOL isSucceed = [_dataBase executeUpdate:@"update userLoginInfoData set userHeadImage=? where userHeadImage=?",str1,str2];
    if (isSucceed) {
    }else{
    }
}

-(void)upNickName:(NSString*)str1 other:(NSString*)str2{
    BOOL isSucceed = [_dataBase executeUpdate:@"update userLoginInfoData set nickName=? where nickName=?",str1,str2];
    if (isSucceed) {
    }else{
    }
}

-(void)upYaoqingma:(NSString*)str1 other:(NSString*)str2{
    BOOL isSucceed = [_dataBase executeUpdate:@"update userLoginInfoData set recommendPreson=? where recommendPreson=?",str1,str2];
    if (isSucceed) {
    }else{
    }
}

@end
