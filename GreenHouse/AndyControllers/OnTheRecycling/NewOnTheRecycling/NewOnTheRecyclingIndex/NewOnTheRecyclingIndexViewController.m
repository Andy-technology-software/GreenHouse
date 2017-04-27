//
//  NewOnTheRecyclingIndexViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/7/22.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "NewOnTheRecyclingIndexViewController.h"

#import "NewOnTheRecyclingIndexCollectionViewCell.h"

#import "nextNewOnTheDoorViewController.h"

#import "RecyclingCarViewController.h"
@interface NewOnTheRecyclingIndexViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,copy)NSString* userid;

@end

@implementation NewOnTheRecyclingIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userid = [MyController getUserid];
    
    // Do any additional setup after loading the view.
    self.imageDataSourceArr = [[NSMutableArray alloc] init];
    self.titleDataSourceArr = [[NSMutableArray alloc] init];
    self.idDataSourceArr = [[NSMutableArray alloc] init];
    self.gilfstyleDataSourceArr = [[NSMutableArray alloc] init];
    self.guigeDataSourceArr = [[NSMutableArray alloc] init];
    self.pointDataSourceArr = [[NSMutableArray alloc] init];
    
    [HUD loading];
    [self createRequest];
    
    [self makeRightCollectionView];
    
    [self createRightNav];
}

- (void)viewWillAppear:(BOOL)animated{
    [self createJiuwucheRequest];
}
- (void)createRightNav{
    rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(160,0,30,30)];
    [rightButton1 setImage:[UIImage imageNamed:@"shopcar"]forState:UIControlStateNormal];
    [rightButton1 addTarget:self action:@selector(carBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem1, nil];
}

- (void)carBtnClick{
    RecyclingCarViewController* vc = [[RecyclingCarViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)makeData{
    for (int i = 0; i < 20; i++) {
        [self.imageDataSourceArr addObject:@"https://img.mdcdn.cn/ImageStore/106834/pic/9c57ed001eaba556A8375/9c57ed001eaba556A8375_430*430.jpg"];
        [self.titleDataSourceArr addObject:@"美的空调"];
    }
}
- (void)makeRightCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], self.view.frame.size.height) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[NewOnTheRecyclingIndexCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleDataSourceArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    NewOnTheRecyclingIndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        cell = [[NewOnTheRecyclingIndexCollectionViewCell alloc] init];
    }
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.imageDataSourceArr[indexPath.item]] placeholderImage:[UIImage imageNamed:@"默认图标乐器"]];
    cell.text.text = self.titleDataSourceArr[indexPath.item];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(([MyController getScreenWidth] - 2)/3, ([MyController getScreenWidth])/3);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    nextNewOnTheDoorViewController* vc = [[nextNewOnTheDoorViewController alloc] init];
    vc.title = self.titleDataSourceArr[indexPath.item];
    vc.idStr = self.idDataSourceArr[indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)createRequest{
    NSString* requestUrl = HUOQUFENLEIRULE;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray* sourceArr = [MyController arraryWithJsonString:responseObject[@"data"]];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  [HUD hide];
                  for (NSDictionary* dic in sourceArr) {
                      [self.imageDataSourceArr addObject:dic[@"imgurl"]];
                      [self.titleDataSourceArr addObject:dic[@"gilfstyle"]];
                      [self.idDataSourceArr addObject:dic[@"id"]];
                  }
                  [_collectionView reloadData];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
          }];
}
- (void)createJiuwucheRequest{
    NSString* requestUrl = CARLIST;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"pnum":@"1",
                                          @"num":@"10"
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              if (sourceArr.count) {
                [rightButton1 setImage:[UIImage imageNamed:@"shopcar_red"]forState:UIControlStateNormal];
              }else{
                  [rightButton1 setImage:[UIImage imageNamed:@"shopcar"]forState:UIControlStateNormal];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
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
