//
//  AboutUsViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIWebViewDelegate>{
    UIActivityIndicatorView *activityIndicatorView;
}

@end

@implementation AboutUsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
        UIWebView*  webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight])];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.autoresizesSubviews = YES;
    
    [self.view addSubview:webView];
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter: self.view.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    [self.view addSubview : activityIndicatorView] ;
    if (![self.urlString hasPrefix:@"http"]) {
        self.urlString = [NSString stringWithFormat:@"http://%@",self.urlString];
    }else{
        
    }
    NSString *encodedString=[[self returnFormatString:self.urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",encodedString]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}
-(NSString *)returnFormatString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@" "];
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicatorView startAnimating] ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicatorView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
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
