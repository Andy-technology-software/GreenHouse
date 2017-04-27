//
//  SeetingViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "SeetingViewController.h"

#import "PersonalCenterModel.h"

#import "PersonalCenter1Model.h"

#import "PersonalCenterTableViewCell.h"

#import "PersonalCenter1TableViewCell.h"

#import "AppDelegate.h"

#import "ForgetPasswordViewController.h"

#import "AboutUsViewController.h"

#import "FeedbackViewController.h"
@interface SeetingViewController ()<UITableViewDataSource,UITableViewDelegate,PersonalCenterTableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;

@end

@implementation SeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)personInfo{
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"退出登录"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    [[DBManager shareManager] deleteLoginData];
    [(AppDelegate *)[UIApplication sharedApplication].delegate logOut];
}
- (void)makeData{
    [self.datasourceArr removeAllObjects];
    [self.datasourceArr1 removeAllObjects];
    
    PersonalCenterModel* s0Model = [[PersonalCenterModel alloc] init];
    s0Model.headImageStr = @"";
    s0Model.zhanghaoStr = @"当前版本号 1.6";
    [self.datasourceArr addObject:s0Model];
    
    NSArray* temA = [[NSArray alloc] initWithObjects:@"密码重置",@"使用反馈",@"关于我们",@"企业QQ  2128493794", nil];
    for (int i = 0; i < temA.count; i++) {
        PersonalCenter1Model* model = [[PersonalCenter1Model alloc] init];
        model.titleStr = temA[i];
        [self.datasourceArr1 addObject:model];
    }
    
    [_tableView reloadData];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
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
    if (0 == section) {
        return self.datasourceArr.count;
    }
    return self.datasourceArr1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            ForgetPasswordViewController* vc = [[ForgetPasswordViewController alloc] init];
            vc.title = @"密码重置";
            vc.isChongzhi = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (1 == indexPath.row){
            FeedbackViewController* vc = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (2 == indexPath.row){
            AboutUsViewController* vc = [[AboutUsViewController alloc] init];
            vc.title = @"关于我们";
            vc.urlString = @"http://www.ronghaohuishou.cn/index.php?v=listing&cid=58&page=1";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"persion0";
        PersonalCenterTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[PersonalCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.PersonalCenterTableViewCellDelegate = self;
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        PersonalCenterModel* model = self.datasourceArr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"persion1";
    PersonalCenter1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[PersonalCenter1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    PersonalCenter1Model* model = self.datasourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        PersonalCenterModel *model = nil;
        if (indexPath.row < self.datasourceArr.count) {
            model = [self.datasourceArr objectAtIndex:indexPath.row];
        }
        return [PersonalCenterTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            PersonalCenterTableViewCell *cell = (PersonalCenterTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    PersonalCenter1Model *model = nil;
    if (indexPath.row < self.datasourceArr1.count) {
        model = [self.datasourceArr1 objectAtIndex:indexPath.row];
    }
    return [PersonalCenter1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        PersonalCenter1TableViewCell *cell = (PersonalCenter1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
