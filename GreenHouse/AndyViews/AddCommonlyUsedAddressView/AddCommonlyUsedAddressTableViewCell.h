//
//  AddCommonlyUsedAddressTableViewCell.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCommonlyUsedAddressModel;
@protocol AddCommonlyUsedAddressTableViewCellDelegate <NSObject>
- (void)sendBackStr:(NSString* )str AndCellIndex:(NSInteger)index;

@end
@interface AddCommonlyUsedAddressTableViewCell : UITableViewCell
- (void)configCellWithModel:(AddCommonlyUsedAddressModel *)model;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,weak)id<AddCommonlyUsedAddressTableViewCellDelegate>AddCommonlyUsedAddressTableViewCellDelegate;

@end
