//
//  GuideViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/6/30.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "GuideViewController.h"

#import "AppDelegate.h"
@interface GuideViewController ()<UIScrollViewDelegate>{
    UIScrollView* sc;
    UIPageControl * pageCtl;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createScroller];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    
//    self.navigationController.navigationBarHidden = YES;
    
}
-(void)createScroller{
    
    sc=[[UIScrollView alloc]initWithFrame:self.view.frame];
    sc.pagingEnabled = YES;
    sc.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sc.directionalLockEnabled = YES;
        sc.contentOffset = CGPointMake([MyController getScreenWidth], 0);
    sc.bounces = NO;
    sc.alwaysBounceHorizontal = NO;
    sc.alwaysBounceVertical = NO;
    sc.scrollEnabled = YES;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    sc.delegate = self;
    sc.contentSize=CGSizeMake([MyController getScreenWidth] * 3, [MyController getScreenHeight]);
    sc.tag=345;
    sc.pagingEnabled=YES;
    NSArray*images=@[@"登录背景",@"预览页",@"登录背景"];
    for (int i = 0; i < 3; i++) {
        UIImageView*imageView = [MyController createImageViewWithFrame:CGRectMake(i*[MyController getScreenWidth], 0, [MyController getScreenWidth], [MyController getScreenHeight]) ImageName:images[i]];
        [sc addSubview:imageView];
        if (i==2) {
            UIButton* loginBtn = [MyController createButtonWithFrame:CGRectMake(0, [MyController getScreenHeight] - 50, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(buttonClick) Title:@"登录"];
            [imageView addSubview:loginBtn];
        }
    }
    
    [self.view addSubview:sc];
    
}
-(void)buttonClick{
    [UIView animateWithDuration:0.5 animations:^{
        [(AppDelegate *)[UIApplication sharedApplication].delegate logOut];
    }];
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"first"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return [scrollView.subviews objectAtIndex:scrollView.contentOffset.x / [MyController getScreenWidth]];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
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
