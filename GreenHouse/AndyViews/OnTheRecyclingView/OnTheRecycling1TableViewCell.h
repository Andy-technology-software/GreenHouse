//
//  OnTheRecycling1TableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OnTheRecycling1Model;
@protocol OnTheRecycling1TableViewCellDelegate <NSObject>
- (void)sendBackZhongliang:(NSString*)zhongliang;
@end
@interface OnTheRecycling1TableViewCell : UITableViewCell
- (void)configCellWithModel:(OnTheRecycling1Model *)model;
@property(nonatomic,weak)id<OnTheRecycling1TableViewCellDelegate>OnTheRecycling1TableViewCellDelegate;

@end
