//
//  IndexS1Cell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/22.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexS1Model;
@protocol IndexS1CellDelegate <NSObject>

- (void)clickS1Btn:(NSInteger)index;
- (void)wodetoudi;
- (void)wodeduihuan;
@end
@interface IndexS1Cell : UITableViewCell
@property(nonatomic,weak)id<IndexS1CellDelegate>IndexS1CellDelegate;

- (void)configCellWithModel:(IndexS1Model *)model;
@end
