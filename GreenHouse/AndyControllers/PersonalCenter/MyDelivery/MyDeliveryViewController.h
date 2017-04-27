//
//  MyDeliveryViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"

#import "MyPointsModel.h"

#import "MyPointsTableViewCell.h"
@interface MyDeliveryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
//请求需要的参数
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)NSInteger pageIndex;

@end
