//
//  JiuwuDetailViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/7/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"

@class JiuwuDetailModel;
@interface JiuwuDetailViewController : BaseViewController
@property(nonatomic,retain)JiuwuDetailModel* jiuwuModel;
@property(nonatomic,copy)NSString* gilfstyle;
@property(nonatomic,copy)NSString* guige;
@property(nonatomic,copy)NSString* point;

@end
