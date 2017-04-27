//
//  RecyclingMapViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "RecyclingMapViewController.h"

#import "MyMapListViewController.h"

#import "MyMapViewController.h"
@interface RecyclingMapViewController ()<UIScrollViewDelegate>{
    MyMapViewController* myMapVC;
    MyMapListViewController* myMapListVC;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@end

@implementation RecyclingMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"回收地图";
    
    [self MakeHMSView];
    
    [self makeScrollView];
}
- (void)MakeHMSView{
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, [MyController getScreenWidth], 40)];
    self.segmentedControl.sectionTitles = @[@"地图模式", @"列表模式"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [MyController colorWithHexString:@"677c8d"]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [MyController colorWithHexString:@"3d8eb9"]};
    self.segmentedControl.selectionIndicatorColor = [MyController colorWithHexString:@"3d8eb9"];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorHeight = 2;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake([MyController getScreenWidth] * index, 0, [MyController getScreenWidth], self.view.frame.size.height - 40) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    UIView* lineView = [MyController viewWithFrame:CGRectMake(0, self.view.frame.size.height - 40, [MyController getScreenWidth], 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    if (0 == segmentedControl.selectedSegmentIndex) {
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"Map",@"Map", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"Map" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }else if (1 == segmentedControl.selectedSegmentIndex){
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"List",@"List", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"List" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}
- (void)makeScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth],  self.view.frame.size.height - 40)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake([MyController getScreenWidth] * 2,  [MyController getScreenHeight] - [MyController isIOS7] - 40);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, [MyController getScreenWidth],  [MyController getScreenHeight] - [MyController isIOS7] - 40) animated:NO];
    [self.view addSubview:self.scrollView];
    
    [self createSliderView];
}
- (void)createSliderView{
    myMapVC = [[MyMapViewController alloc] init];
    myMapVC.view.frame = CGRectMake([MyController getScreenWidth] * 0, 0, [MyController getScreenWidth], self.view.frame.size.height - 40);
    [self addChildViewController:myMapVC];
    [self.scrollView addSubview:myMapVC.view];
    
    myMapListVC = [[MyMapListViewController alloc] init];
    myMapListVC.view.frame = CGRectMake([MyController getScreenWidth] * 1, 0, [MyController getScreenWidth], self.view.frame.size.height - 40);
    [self addChildViewController:myMapListVC];
    [self.scrollView addSubview:myMapListVC.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / pageWidth;
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    }
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
