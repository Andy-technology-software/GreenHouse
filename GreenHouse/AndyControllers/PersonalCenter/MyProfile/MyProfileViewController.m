//
//  MyProfileViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyProfileViewController.h"

#import "MyProfile0Model.h"

#import "MyProfile1Model.h"

#import "MyProfileView0TableViewCell.h"

#import "MyProfileView1TableViewCell.h"

#import "MyProfileViewInputInfoViewController.h"

#import "MyProfileViewSelectInfoViewController.h"

#import "MyAddressViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import <MobileCoreServices/MobileCoreServices.h>
@interface MyProfileViewController ()<UITableViewDataSource,UITableViewDelegate,MyProfileView0TableViewCellDelegate,UIActionSheetDelegate,VPImageCropperDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,MyProfileViewInputInfoViewControllerDelegate,MyProfileViewSelectInfoViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,assign)NSInteger seleCellIndex;
@property(nonatomic,assign)BOOL isChangeHeadImage;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* infoName;
@property(nonatomic,copy)NSString* infoValue;
@property(nonatomic,copy)NSString* birthdyValue;
@property(nonatomic,copy)NSString* imgs;
@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的资料";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    
    self.userid = [MyController getUserid];
    self.imgs = @"";
    
    [self createTableView];
    
    [HUD loading];
    [self createInfoRequest];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)sendBackSelectstr:(NSString *)str{
    
    [HUD loading];
    self.infoValue = str;
    if (3 == self.seleCellIndex) {
        self.infoName = @"sex";
        [self createUserInfoUpdateRequest];
    }
}
- (void)sendBackStr:(NSString *)str{
    [HUD loading];
    self.infoValue = str;
    if (1 == self.seleCellIndex) {
        //昵称
        self.infoName = @"truename";//[NSString stringWithFormat:@"{\"truename\":\"%@\"}",str];
        [self createUserInfoUpdateRequest];
    }else if (2 == self.seleCellIndex) {
        //年龄
        self.infoName = @"birthday";//[NSString stringWithFormat:@"{\"birthday\":\"%@\"}",str];
        [self createUserInfoUpdateRequest];
    }else if (6 == self.seleCellIndex) {
        //兴趣爱好
        self.infoName = @"hobbies";//[NSString stringWithFormat:@"{\"hobbies\":\"%@\"}",str];
        [self createUserInfoUpdateRequest];
    }else if (7 == self.seleCellIndex) {
        //qq
        self.infoName = @"qq";//[NSString stringWithFormat:@"{\"qq\":\"%@\"}",str];
        [self createUserInfoUpdateRequest];
    }else if (8 == self.seleCellIndex) {
        //邮箱
        self.infoName = @"email";//[NSString stringWithFormat:@"{\"email\":\"%@\"}",str];
        [self createUserInfoUpdateRequest];
    }else if (4 == self.seleCellIndex) {
        //城市
        self.infoName = @"livecity";//[NSString stringWithFormat:@"{\"email\":\"%@\"}",str];
        [self createUserInfoUpdateRequest];
    }
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.datasourceArr.count;
    }
    return self.datasourceArr1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            
        }else if (1 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            MyProfileViewInputInfoViewController* vc = [[MyProfileViewInputInfoViewController alloc] init];
            vc.title = @"修改昵称";
            vc.placrInfo = @"请输入您的昵称";
            vc.MyProfileViewInputInfoViewControllerDelegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (2 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            
            UIDatePicker *picker = [[UIDatePicker alloc]init];
            picker.datePickerMode = UIDatePickerModeDate;
            
            picker.frame = CGRectMake(0, 40, 320, 200);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [HUD loading];
                
                NSDate *date = picker.date;
                
                self.infoValue = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                self.birthdyValue = [dateFormatter stringFromDate:date];
                
                self.infoName = @"birthday";//[NSString stringWithFormat:@"{\"birthday\":\"%@\"}",str];
                [self createUserInfoUpdateRequest];
                
            }];
            [alertController.view addSubview:picker];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else if (3 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            MyProfileViewSelectInfoViewController* vc = [[MyProfileViewSelectInfoViewController alloc] init];
            vc.MyProfileViewSelectInfoViewControllerDelegate = self;
            vc.title = @"请选择您的性别";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (4 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            MyProfileViewInputInfoViewController* vc = [[MyProfileViewInputInfoViewController alloc] init];
            vc.title = @"城市";
            vc.placrInfo = @"请输入您所在城市";
            vc.MyProfileViewInputInfoViewControllerDelegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (5 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            MyAddressViewController* vc = [[MyAddressViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (6 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            MyProfileViewInputInfoViewController* vc = [[MyProfileViewInputInfoViewController alloc] init];
            vc.title = @"兴趣爱好";
            vc.placrInfo = @"请输入您的兴趣爱好";
            vc.MyProfileViewInputInfoViewControllerDelegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (7 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            MyProfileViewInputInfoViewController* vc = [[MyProfileViewInputInfoViewController alloc] init];
            vc.title = @"QQ";
            vc.placrInfo = @"请输入您的QQ号码";
            vc.MyProfileViewInputInfoViewControllerDelegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (8 == indexPath.row){
            self.seleCellIndex = indexPath.row;
            MyProfileViewInputInfoViewController* vc = [[MyProfileViewInputInfoViewController alloc] init];
            vc.title = @"邮箱";
            vc.placrInfo = @"请输入您的邮箱";
            vc.MyProfileViewInputInfoViewControllerDelegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"myper0";
        MyProfileView0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[MyProfileView0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.MyProfileView0TableViewCellDelegate = self;
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        MyProfile0Model* model = self.datasourceArr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"myper1";
    MyProfileView1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MyProfileView1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MyProfile1Model* model = self.datasourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        MyProfile0Model *model = nil;
        if (indexPath.row < self.datasourceArr.count) {
            model = [self.datasourceArr objectAtIndex:indexPath.row];
        }
        return [MyProfileView0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            MyProfileView0TableViewCell *cell = (MyProfileView0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    MyProfile1Model *model = nil;
    if (indexPath.row < self.datasourceArr1.count) {
        model = [self.datasourceArr1 objectAtIndex:indexPath.row];
    }
    return [MyProfileView1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MyProfileView1TableViewCell *cell = (MyProfileView1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (void)personInfo{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照",nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                             }];
        }
        
    } else if (buttonIndex == 0) {
        [self fromLiuYanBanSeleXiangce];
    }
}
- (void)fromLiuYanBanSeleXiangce{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:UIBarMetricsDefault];
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:17]};
    picker.maximumNumberOfSelection = 1;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    MyProfile0Model* model = [self.datasourceArr lastObject];
    model.headImage = editedImage;
    NSData *_data = UIImageJPEGRepresentation(editedImage, 0.1);
    NSInteger imagM = _data.length/1024/1024;
    if(imagM > 2){
        _data = UIImageJPEGRepresentation(editedImage, 2/imagM);
    }

    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        self.imgs = [_data base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
        [HUD loading];
        self.infoName = @"";
        self.infoValue = @"";
        self.isChangeHeadImage = YES;
        [self createUserInfoUpdateRequest];
    }];
}
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [picker dismissViewControllerAnimated:YES completion:^() {
            UIImage *portraitImg = tempImg;
            VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:[self fixOrientation:portraitImg] cropFrame:CGRectMake(0, ([MyController getScreenHeight] - [MyController getScreenWidth])/2, [MyController getScreenWidth], [MyController getScreenWidth]) limitScaleRatio:3.0];
            imgEditorVC.delegate = self;
            [self presentViewController:imgEditorVC animated:YES completion:^{
            }];
        }];
    }
}

-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
                VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:[self fixOrientation:portraitImg] cropFrame:CGRectMake(0, ([MyController getScreenHeight] - [MyController getScreenWidth])/2, [MyController getScreenWidth], [MyController getScreenWidth]) limitScaleRatio:3.0];
                imgEditorVC.delegate = self;
                [self presentViewController:imgEditorVC animated:YES completion:^{
                }];
    }];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
- (void)createInfoRequest{
    [self.datasourceArr removeAllObjects];
    [self.datasourceArr1 removeAllObjects];
    
    NSString* requestAddress = GETUSERINFOURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  NSDictionary *dic  = [MyController dictionaryWithJsonString:dataStr];
                  NSArray* temA = [[NSArray alloc] initWithObjects:@"手机号",@"昵称",@"生日",@"性别",@"城市",@"详细地址",@"兴趣爱好",@"QQ",@"邮箱", nil];
                  NSString* sexStr = dic[@"sex"];

                  NSArray* temA1 = [[NSArray alloc] initWithObjects:dic[@"mobile"],dic[@"truename"],dic[@"birthday"],sexStr,dic[@"livecity"],dic[@"address"],dic[@"hobbies"],dic[@"qq"],dic[@"email"], nil];
                  for (int i = 0; i < temA.count; i++) {
                      MyProfile1Model* model = [[MyProfile1Model alloc] init];
                      model.titleStr = temA[i];
                      model.titleStr1 = temA1[i];
                      [self.datasourceArr1 addObject:model];
                  }
                  
                  LoginDataBaseModel* loginM = [[[DBManager shareManager] getAllLoginModel] firstObject];
                  [[DBManager shareManager] upDataHeadImage:dic[@"img"] other:loginM.userHeadImage];
                  
                  UIImageView* temIV = [[UIImageView alloc] init];
                  
                  
                  [temIV sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:[UIImage imageNamed:@"shezhitupian"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                      
                  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                      [self.datasourceArr removeAllObjects];
                      MyProfile0Model* s0Model = [[MyProfile0Model alloc] init];
                      s0Model.headImageStr = dic[@"img"];
                      s0Model.headImage = temIV.image;
                      [self.datasourceArr addObject:s0Model];
                      
                      [[DBManager shareManager] upDataHeadImage:dic[@"img"] other:loginM.userHeadImage];
                      
                      self.isChangeHeadImage = NO;
                      [_tableView reloadData];
                  }];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}

- (void)createUserInfoUpdateRequest{
    NSString* requestAddress = USERINFOUPDATA;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = INTERVALTIME;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"infoName":self.infoName,
                                              @"infoValue":self.infoValue,
                                              @"imgs":self.imgs
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  NSDictionary* tDic = [MyController dictionaryWithJsonString:[responseObject objectForKey:@"data"]];
                  
                  LoginDataBaseModel* dataModel = [[[DBManager shareManager] getAllLoginModel] firstObject];
                  
                  if (self.isChangeHeadImage) {
                      [self.datasourceArr removeAllObjects];
   
                      UIImageView* temIV = [[UIImageView alloc] init];
                      
                      [temIV sd_setImageWithURL:[NSURL URLWithString:tDic[@"img"]] placeholderImage:[UIImage imageNamed:@"shezhitupian"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          cacheType = SDImageCacheTypeNone;
                          
                          [[[SDWebImageManager sharedManager] imageCache] clearDisk];
                          [[[SDWebImageManager sharedManager] imageCache] clearMemory];
                          [[NSURLCache sharedURLCache] removeAllCachedResponses];
                          
                          MyProfile0Model* s0Model = [[MyProfile0Model alloc] init];
                          s0Model.headImageStr = tDic[@"img"];
                          s0Model.headImage = temIV.image;
                          [self.datasourceArr addObject:s0Model];
                          
                          [[DBManager shareManager] upDataHeadImage:tDic[@"img"] other:dataModel.userHeadImage];
                          NSLog(@"----%@",dataModel.userHeadImage);
                          self.isChangeHeadImage = NO;
                          [HUD success:tDic[@"msg"]];
                          [_tableView reloadData];
                      }];
                  }else{
                      MyProfile1Model* model = self.datasourceArr1[self.seleCellIndex];
                      if (3 == self.seleCellIndex) {
                          if ([self.infoValue intValue]) {
                              model.titleStr1 = @"男";
                          }else{
                              model.titleStr1 = @"女";
                          }
                      }else if (1 == self.seleCellIndex) {
                          model.titleStr1 = self.infoValue;
                          [[DBManager shareManager] upNickName:self.infoValue other:dataModel.nickName];
                      }else if (2 == self.seleCellIndex) {
                          model.titleStr1 = self.birthdyValue;
                      }else{
                          model.titleStr1 = self.infoValue;
                      }
                      [HUD success:tDic[@"msg"]];
                      [_tableView reloadData];
                  }
                  
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
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
