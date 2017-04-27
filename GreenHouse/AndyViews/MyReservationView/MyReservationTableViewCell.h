//
//  MyReservationTableViewCell.h
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyReservationModel;
@interface MyReservationTableViewCell : UITableViewCell
- (void)configCellWithModel:(MyReservationModel *)model;

@end
