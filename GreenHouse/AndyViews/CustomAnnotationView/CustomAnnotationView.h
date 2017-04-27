//
//  CustomAnnotationView.h
//  AndyCoder
//
//  Created by lingnet on 16/4/12.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

#import "CustomCalloutView.h"
@interface CustomAnnotationView : MAAnnotationView
@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end
