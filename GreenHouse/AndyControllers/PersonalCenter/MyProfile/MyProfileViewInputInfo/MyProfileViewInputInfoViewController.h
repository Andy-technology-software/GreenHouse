//
//  MyProfileViewInputInfoViewController.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@protocol MyProfileViewInputInfoViewControllerDelegate <NSObject>
- (void)sendBackStr:(NSString*)str;
@end
@interface MyProfileViewInputInfoViewController : BaseViewController
@property(nonatomic,copy)NSString* placrInfo;
@property(nonatomic,weak)id<MyProfileViewInputInfoViewControllerDelegate>MyProfileViewInputInfoViewControllerDelegate;
@end
