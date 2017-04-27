//
//  NewOnTheRecyclingIndexViewController.h
//  AndyCoder
//
//  Created by lingnet on 16/7/22.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"

@interface NewOnTheRecyclingIndexViewController : BaseViewController{
    UIButton*rightButton1;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray* imageDataSourceArr;
@property(nonatomic,retain)NSMutableArray* titleDataSourceArr;
@property(nonatomic,retain)NSMutableArray* idDataSourceArr;

@property(nonatomic,retain)NSMutableArray* gilfstyleDataSourceArr;
@property(nonatomic,retain)NSMutableArray* guigeDataSourceArr;
@property(nonatomic,retain)NSMutableArray* pointDataSourceArr;
@end
