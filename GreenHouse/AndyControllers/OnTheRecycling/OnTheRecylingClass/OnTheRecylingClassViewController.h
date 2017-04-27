//
//  OnTheRecylingClassViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/6/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@protocol OnTheRecylingClassViewControllerDelegate <NSObject>
- (void)sendBackClassStr:(NSString* )classStr AndIdStr:(NSString *)idStr Andgilfno:(BOOL)isGilfnoStr;

@end
@interface OnTheRecylingClassViewController : BaseViewController
@property(nonatomic,weak)id<OnTheRecylingClassViewControllerDelegate>OnTheRecylingClassViewControllerDelegate;

@end
