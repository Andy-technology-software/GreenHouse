//
//  MyProfileViewSelectInfoViewController.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@protocol MyProfileViewSelectInfoViewControllerDelegate <NSObject>
- (void)sendBackSelectstr:(NSString*)str;
@end
@interface MyProfileViewSelectInfoViewController : BaseViewController
@property(nonatomic,weak)id<MyProfileViewSelectInfoViewControllerDelegate>MyProfileViewSelectInfoViewControllerDelegate;

@end
