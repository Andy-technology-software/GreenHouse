//
//  GiftDetailTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GiftDetailS0Model;
@protocol GiftDetailS0CellDelegate <NSObject>

- (void)indexSeleAD:(NSInteger)index;
- (void)selectWhichBtn:(NSInteger)index;
@end
@interface GiftDetailTableViewCell : UITableViewCell
- (void)configCellWithModel:(GiftDetailS0Model *)model;
@property(nonatomic,weak)id<GiftDetailS0CellDelegate>GiftDetailS0Delegate;
@end
