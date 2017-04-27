//
//  MyMapViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyMapViewController.h"

#import <MAMapKit/MAMapKit.h>

#import "CustomAnnotationView.h"

#import "MAPointAnnotation_MyMAPointAnnotation.h"
@interface MyMapViewController ()<MAMapViewDelegate>
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property (nonatomic,assign)CLLocationCoordinate2D dingwei;
@property(nonatomic,copy)NSString* userid;

@end
@implementation MyMapViewController{
    MAMapView *_mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [MAMapServices sharedServices].apiKey = @"3b6db5764b7916af195484bfda2f79da";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = 1;
    
    [self.view addSubview:_mapView];
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    self.userid = [MyController getUserid];
    
    [self getLat];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Map:) name:@"Map" object:nil];
}
- (void)Map:(NSNotification *)text{
    [self getLat];
    
}
-(void)getLat {
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        self.dingwei = locationCorrrdinate;
        
        [self createRequest];
    }];
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        MAPointAnnotation* temAnn = (MAPointAnnotation*)annotation;

        if ([temAnn.subtitle rangeOfString:@"异常"].location != NSNotFound) {
            annotationView.image = [UIImage imageNamed:@"red"];
        }else if ([temAnn.subtitle rangeOfString:@"非正常"].location != NSNotFound){
            annotationView.image = [UIImage imageNamed:@"yellow"];
        }else{
            annotationView.image = [UIImage imageNamed:@"green"];
        }
        
        annotationView.canShowCallout = NO;
        
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (void)createRequest{
    self.datasourceArr = [[NSMutableArray alloc] init];
    NSString* requestUrl = BACKMAPURL;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"jingdu":[NSString stringWithFormat:@"%.f",self.dingwei.longitude],
                                          @"weidu":[NSString stringWithFormat:@"%.f",self.dingwei.latitude]
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  NSMutableArray* aa = [[NSMutableArray alloc] init];
                  for (NSDictionary* dic in sourceArr) {
                      MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                      pointAnnotation.coordinate = CLLocationCoordinate2DMake([dic[@"weidu"] floatValue], [dic[@"jingdu"] floatValue]);
                      pointAnnotation.title = dic[@"jtdz"];
                      pointAnnotation.subtitle = [NSString stringWithFormat:@"%@ - %@",dic[@"hsxbh"],dic[@"hsxzt"]];
                      [aa addObject:pointAnnotation];
                  }
                  [_mapView addAnnotations:aa];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
          }];
}

@end
