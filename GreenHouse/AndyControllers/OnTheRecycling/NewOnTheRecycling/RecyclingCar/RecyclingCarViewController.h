//
//  RecyclingCarViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"

#import "RecyclingCarModel.h"

#import "RecyclingCarTableViewCell.h"
@interface RecyclingCarViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,RecyclingCarTableViewCellDelegate>{
    UITableView* _tableView;
    UIButton* makeSureBtn;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,assign)BOOL isSelectAll;
@property(nonatomic,retain)NSMutableArray* idDatasourceArr;

@end
