//
//  AppDelegate.m
//  AndyCoder
//
//  Created by lingnet on 16/4/6.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppDelegate.h"

#import "IndexViewController.h"

#import "LoginViewController.h"
@interface AppDelegate ()<UIAlertViewDelegate,UIAlertViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSArray* dataArr = [[DBManager shareManager] getAllLoginModel];
    if (dataArr.count) {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[IndexViewController alloc] init]];
        [self createLoginRequest];
    }else{
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    }

    [self.window makeKeyAndVisible];
    
    [self onCheckVersion];
    
    return YES;
}
-(void)logOut{
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
}

- (void)setIndexVC{
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[IndexViewController alloc] init]];

}
-(void)onCheckVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSString *URL = @"http://itunes.apple.com/lookup?id=1129582108";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [MyController dictionaryWithJsonString:results];//[results JSONValue];
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        if ([lastVersion floatValue] > [currentVersion floatValue]) {//![lastVersion isEqualToString:currentVersion]
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已有新版本，请点击更新" delegate:self cancelButtonTitle:@"现在就去" otherButtonTitles: nil];
            al.tag = 10000;
            [al show];
        }
    }
}
- (void)exitApplication {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    //exit(0);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10000) {
        if (buttonIndex==0) {
            [self exitApplication];
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/lu-se-fang-hui-shou/id1129582108?l=zh&ls=1&mt=8"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }else{
        [self logOut];
    }
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)createLoginRequest{
    LoginDataBaseModel* mo = [[[DBManager shareManager] getAllLoginModel] lastObject];
    NSString* requestAddress = LOGINURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"username":mo.phoneNum,
                                              @"password":mo.password
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  
              }else{
                  UIAlertView* al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的密码已重置，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                  al.tag = 900;
                  [al show];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}

@end
