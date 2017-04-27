//
//  PicReviewViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "PicReviewViewController.h"

@interface PicReviewViewController ()

@end

@implementation PicReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title                                                  = @"图片浏览";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)createSC{
    self.automaticallyAdjustsScrollViewInsets                   = NO;
    _sv.backgroundColor                                         = [UIColor colorWithRed:219/255.0 green:225/255.0 blue:230/255.0 alpha:1];
    _sv                                                         = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_sv];
    for (int i                                                  = 0; i < self.pictureArr.count; i++) {
        UIImageView* imageView                                      = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.tag                                               = 100 + i;
        [imageView sd_setImageWithURL:self.pictureArr[i] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
        [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        imageView.contentMode                                       = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask                                  = UIViewAutoresizingFlexibleHeight;
        imageView.clipsToBounds                                     = YES;
        [_sv addSubview:imageView];
        
    }
    _sv.contentSize                                             = CGSizeMake(self.view.frame.size.width * self.pictureArr.count, self.view.frame.size.height);
    _sv.contentOffset                                           = CGPointMake(self.view.frame.size.width*[self.numStr intValue], 0);
    _sv.pagingEnabled                                           = YES;
    _sv.contentInset                                            = UIEdgeInsetsMake(0, 0, 0, 0);
    _sv.directionalLockEnabled                                  = YES;
    _sv.bounces                                                 = YES;
    _sv.alwaysBounceHorizontal                                  = YES;
    _sv.alwaysBounceVertical                                    = NO;
    _sv.scrollEnabled                                           = YES;
    _sv.showsHorizontalScrollIndicator                          = NO;
    _sv.showsVerticalScrollIndicator                            = NO;
    _sv.indicatorStyle                                          = UIScrollViewIndicatorStyleWhite;
    _sv.decelerationRate                                        = 0.5;
    _sv.delegate                                                = self;
}

#pragma mark - 滚动结束后调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.dangqianSelect                                         = (int)(scrollView.contentOffset.x / self.view.frame.size.width);
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
