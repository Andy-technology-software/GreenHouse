//
//  JiuwuDetailViewTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/7/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JiuwuDetailModel;
@protocol JiuwuDetailViewTableViewCellDelegate <NSObject>
- (void)sendBackShuliangStr:(NSString* )shuliangStr;

@end
@interface JiuwuDetailViewTableViewCell : UITableViewCell
- (void)configCellWithModel:(JiuwuDetailModel *)model;
@property(nonatomic,weak)id<JiuwuDetailViewTableViewCellDelegate>JiuwuDetailViewTableViewCellDelegate;

@end
