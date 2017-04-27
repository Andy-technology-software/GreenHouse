//
//  MyProfileViewSelectInfoViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyProfileViewSelectInfoViewController.h"

#import "MyProfileViewSelectInfoModel.h"

#import "MyProfileViewSelectInfoTableViewCell.h"
@interface MyProfileViewSelectInfoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;

@end

@implementation MyProfileViewSelectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    [self makeData];
    
    [self createTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)makeData{
    NSArray* temA = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
    NSArray* temA1 = [[NSArray alloc] initWithObjects:@"1",@"0", nil];
    for (int i = 0; i < temA.count; i++) {
        MyProfileViewSelectInfoModel* model = [[MyProfileViewSelectInfoModel alloc] init];
        model.titleStr = temA[i];
        model.titleIdStr = temA1[i];
        [self.datasourceArr addObject:model];
    }
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyProfileViewSelectInfoModel* model = self.datasourceArr[indexPath.row];
    [self.MyProfileViewSelectInfoViewControllerDelegate sendBackSelectstr:model.titleIdStr];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"MyProfileViewSelectInfo";
    MyProfileViewSelectInfoTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MyProfileViewSelectInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MyProfileViewSelectInfoModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyProfileViewSelectInfoModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [MyProfileViewSelectInfoTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MyProfileViewSelectInfoTableViewCell *cell = (MyProfileViewSelectInfoTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
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
