//
//  PicReviewViewController.h
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"

@interface PicReviewViewController : BaseViewController<UIScrollViewDelegate>{
    UIScrollView* _sv;
    UIPageControl* _pc;
}
@property(nonatomic,retain) NSArray* pictureArr;
@property(nonatomic, copy)NSString* numStr;
@property(nonatomic, assign)NSInteger dangqianSelect;

@end
