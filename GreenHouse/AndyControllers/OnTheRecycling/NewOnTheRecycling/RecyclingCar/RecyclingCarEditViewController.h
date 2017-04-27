//
//  RecyclingCarEditViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "RecyclingCarViewController.h"
@protocol RecyclingCarEditViewControllerDelegate <NSObject>
- (void)sendBackIdStr:(NSString* )idStr;

@end
@interface RecyclingCarEditViewController : RecyclingCarViewController
@property(nonatomic,weak)id<RecyclingCarEditViewControllerDelegate>RecyclingCarEditViewControllerDelegate;
@end
