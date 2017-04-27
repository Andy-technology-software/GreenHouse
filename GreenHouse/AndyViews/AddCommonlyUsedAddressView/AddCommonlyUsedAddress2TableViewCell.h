//
//  AddCommonlyUsedAddress2TableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/6/3.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCommonlyUsedAddress2Model;
@protocol AddCommonlyUsedAddress2TableViewCellDelegate <NSObject>
- (void)send2BackStr:(NSString* )str AndCellIndex:(NSInteger)index;
- (void)send2BackAreaStr:(NSString* )prostr andCityStr:(NSString*)cityStr andAreaStr:(NSString*)areaStr;

@end
@interface AddCommonlyUsedAddress2TableViewCell : UITableViewCell
- (void)configCellWithModel:(AddCommonlyUsedAddress2Model *)model;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,weak)id<AddCommonlyUsedAddress2TableViewCellDelegate>AddCommonlyUsedAddress2TableViewCellDelegate;

@end
