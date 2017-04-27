//
//  IndexS0Cell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexS0Model;
@protocol IndexS0CellDelegate <NSObject>

- (void)indexSeleAD:(NSInteger)index;

@end
@interface IndexS0Cell : UITableViewCell
- (void)configCellWithModel:(IndexS0Model *)model;
@property(nonatomic,weak)id<IndexS0CellDelegate>IndexS0CellDelegate;
@end
