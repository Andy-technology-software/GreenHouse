 //
//  RecyclingCarEditViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "RecyclingCarEditViewController.h"

@interface RecyclingCarEditViewController (){
    UIButton* makeSureBtn;
}
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* deleIdStr;
@property(nonatomic,copy)NSString* totleDeleIdStr;
@property(nonatomic,assign)BOOL isDelete;
@end

@implementation RecyclingCarEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userid = [MyController getUserid];
    
    self.totleDeleIdStr = @"";
}
- (void)createRightNav{
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(160,0,40,30)];
    [rightButton1 setTitle:@"完成" forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton1 addTarget:self action:@selector(carBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem1, nil];
}

- (void)carBtnClick{
    if (self.isDelete) {
        [self.RecyclingCarEditViewControllerDelegate sendBackIdStr:self.totleDeleIdStr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backBtnClick{
    if (self.isDelete) {
        [self.RecyclingCarEditViewControllerDelegate sendBackIdStr:self.totleDeleIdStr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    makeSureBtn = [MyController createButtonWithFrame:CGRectMake(10, 10, 20, 20) ImageName:@"不爱点击" Target:self Action:@selector(selectAllBtnClick) Title:nil];
    [bottomView addSubview:makeSureBtn];
    
    UILabel* quanxuanLable = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(makeSureBtn.frame) + 5, 0, 40, 40) Font:14 Text:@"全选"];
    [bottomView addSubview:quanxuanLable];
    
    UIButton* makeSureBtntem = [MyController createButtonWithFrame:CGRectMake(0, 0, 75, 40) ImageName:nil Target:self Action:@selector(selectAllBtnClick) Title:nil];
    [bottomView addSubview:makeSureBtntem];
    
    
    UIButton* makeSureBtn1 = [MyController createButtonWithFrame:CGRectMake([MyController getScreenWidth] - 80, 0, 80, 40) ImageName:nil Target:self Action:@selector(deleBtnClick) Title:@"删除"];
    [makeSureBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    makeSureBtn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [makeSureBtn1 setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    [bottomView addSubview:makeSureBtn1];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [bottomView addSubview:lineV];
}

- (void)selectAllBtnClick{
    self.isSelectAll = !self.isSelectAll;
    self.deleIdStr = @"";
    if (self.isSelectAll) {
        [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"爱点击"] forState:UIControlStateNormal];
        for (int i = 0; i < self.datasourceArr.count; i++) {
            RecyclingCarModel* model = self.datasourceArr[i];
            self.deleIdStr = [self.deleIdStr stringByAppendingString:[NSString stringWithFormat:@"%@,",model.idStr]];
        }
        self.deleIdStr = [self.deleIdStr substringToIndex:self.deleIdStr.length - 1];
    }else{
        [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"不爱点击"] forState:UIControlStateNormal];
        self.deleIdStr = @"";
    }
    for (int i = 0; i < self.datasourceArr.count; i++) {
        RecyclingCarModel* model = self.datasourceArr[i];
        model.isSelected = self.isSelectAll;
    }
    [_tableView reloadData];
}
- (void)sendBackSelectCarNum:(NSInteger)cellIndex{
    self.deleIdStr = @"";
    RecyclingCarModel* model = self.datasourceArr[cellIndex];
    model.isSelected = !model.isSelected;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:cellIndex inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    for (int i = 0; i < self.datasourceArr.count; i++) {
        RecyclingCarModel* model = self.datasourceArr[i];
        if (model.isSelected) {
            self.deleIdStr = [self.deleIdStr stringByAppendingString:[NSString stringWithFormat:@"%@,",model.idStr]];
        }
    }
    self.deleIdStr = [self.deleIdStr substringToIndex:self.deleIdStr.length - 1];
}

- (void)deleBtnClick{
    if (![MyController isBlankString:self.deleIdStr]) {
        [self createDeleteCarRequest];
    }else{
        [HUD warning:@"请选择要删除的物品"];
    }
}
- (void)createDeleteCarRequest{
    NSString* requestUrl = DELETECAR;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"id ":self.deleIdStr
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([responseObject[@"result"] intValue]) {
                  if ([MyController isBlankString:self.totleDeleIdStr]) {
                      self.totleDeleIdStr = [self.totleDeleIdStr stringByAppendingString:[NSString stringWithFormat:@"%@",self.deleIdStr]];
                  }else{
                      self.totleDeleIdStr = [self.totleDeleIdStr stringByAppendingString:[NSString stringWithFormat:@",%@",self.deleIdStr]];
                  }
                NSArray *array = [self.deleIdStr componentsSeparatedByString:@","];
                  int i = (int)[self.idDatasourceArr count] - 1;
                  for(;i >= 0;i --){
                      if([array containsObject:[self.idDatasourceArr objectAtIndex:i]]) {
                          [self.datasourceArr removeObjectAtIndex:i];
                          [self.idDatasourceArr removeObjectAtIndex:i];
                      }  
                  }
                  self.isDelete = YES;
                  [_tableView reloadData];
                  
                  [HUD success:responseObject[@"data"]];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
          }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
