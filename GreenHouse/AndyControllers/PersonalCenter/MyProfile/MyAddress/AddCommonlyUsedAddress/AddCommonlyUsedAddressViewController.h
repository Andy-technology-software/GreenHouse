//
//  AddCommonlyUsedAddressViewController.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"
@protocol AddCommonlyUsedAddressViewControllerDelegate <NSObject>
- (void)sendBackNeedLoading:(BOOL)needLoading;
@end
@interface AddCommonlyUsedAddressViewController : BaseViewController
@property(nonatomic,weak)id<AddCommonlyUsedAddressViewControllerDelegate>AddCommonlyUsedAddressViewControllerDelegate;

@end
