//
//  RecyclingCarModel.h
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecyclingCarModel : NSObject
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,copy)NSString* headImageStr;
@property(nonatomic,copy)NSString* titleStr;
@property(nonatomic,copy)NSString* numStr;
@property(nonatomic,assign)NSInteger carNum;
@property(nonatomic,copy)NSString* priceStr;
@property(nonatomic,assign)BOOL isFromMakesure;
@property(nonatomic,assign)float point;
@property(nonatomic,copy)NSString* idStr;

@end
