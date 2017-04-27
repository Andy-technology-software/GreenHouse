//
//  RecyclingCarTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecyclingCarModel;
@protocol RecyclingCarTableViewCellDelegate <NSObject>
- (void)sendBackSelectCarNum:(NSInteger )cellIndex;

@end
@interface RecyclingCarTableViewCell : UITableViewCell
- (void)configCellWithModel:(RecyclingCarModel *)model;
@property(nonatomic,weak)id<RecyclingCarTableViewCellDelegate>RecyclingCarTableViewCellDelegate;
@property(nonatomic,assign)NSInteger cellIndex;
@end
