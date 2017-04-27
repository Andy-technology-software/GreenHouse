//
//  OnTheRecycling2TableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OnTheRecycling2Model;
@protocol OnTheRecycling2TableViewCellDelegate <NSObject>
- (void)sendBackTel:(NSString*)tel;
- (void)xizeClick;
@end
@interface OnTheRecycling2TableViewCell : UITableViewCell
- (void)configCellWithModel:(OnTheRecycling2Model *)model;
@property(nonatomic,weak)id<OnTheRecycling2TableViewCellDelegate>OnTheRecycling2TableViewCellDelegate;
@end
