//
//  YNUpdateInforViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/29.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNUpdateInforViewController.h"
#import "YNUpdateInforTableView.h"
#import "YNUpdatePhoneViewController.h"
#import "YNUpdatePswordViewController.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"

@interface YNUpdateInforViewController ()<TZImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
}
@property (nonatomic, weak) UIImagePickerController *imagePickerVc;

@property (nonatomic,weak) YNUpdateInforTableView * tableView;

@end

@implementation YNUpdateInforViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startNetWorkingRequestWithUserInfors];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithUserInfors{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"]};
    [YNHttpManagers getUserInforsWithParams:params success:^(id response) {
        self.tableView.inforDict = response;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithupdateUserInfors{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"idcardId":_tableView.idcardId,
                             @"nickname":_tableView.nickname};
    [YNHttpManagers updateUserInforsWithParams:params success:^(id response) {
        
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithChangeUserImageWithImage:(UIImage*)image{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"]};
    [YNHttpManagers changeUserImageWithImage:image Params:params success:^(id response) {
        [self startNetWorkingRequestWithUserInfors];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNUpdateInforTableView *)tableView{
    if (!_tableView) {
        YNUpdateInforTableView *tableView = [[YNUpdateInforTableView alloc] init];
        _tableView = tableView;
        [tableView setDidSelectUpdateInforClickBlock:^(NSString *str) {
            if ([str isEqualToString:@"手机号码"]) {
                YNUpdatePhoneViewController *pushVC = [[YNUpdatePhoneViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([str isEqualToString:@"账户安全"]){
                YNUpdatePswordViewController *pushVC = [[YNUpdatePswordViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        [tableView setDidSelectChangeImgBlock:^{
            [self handleSelectOpenPhotos];
        }];
        [self.view addSubview:tableView];
    }
    return _tableView;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (!_imagePickerVc) {
         UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc  = imagePickerVc;
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:@"保存" selectTitle:@"保存" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        [weakSelf startNetWorkingRequestWithupdateUserInfors];
    }];
    self.titleLabel.text = @"个人资料修改";
}
-(void)makeUI{
    [super makeUI];
}
-(void)handleSelectOpenPhotos{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}
#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == kCLAuthorizationStatusRestricted || authStatus == kCLAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}
#pragma mark - TZImagePickerController
- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.allowTakePicture = YES;
    // 2. Set the appearance
     imagePickerVc.navigationBar.barTintColor = COLOR_DF463E;
    // 3. Set allow picking video & photo & originalPhoto or not
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingImage = YES;

    /// 5. Single selection mode, valid when maxImagesCount = 1
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;
    imagePickerVc.circleCropRadius = W_RATIO(200);
    [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
        cropView.layer.borderColor = [UIColor whiteColor].CGColor;
        cropView.layer.borderWidth = W_RATIO(10);
    }];
#pragma mark - 到这里为止
    // You can get the photos by block, the same as by delegate.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self startNetWorkingRequestWithChangeUserImageWithImage:photos.firstObject];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                    [tzImagePickerVc hideProgressHUD];
                    TZAssetModel *assetModel = [models lastObject];
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                        [self startNetWorkingRequestWithChangeUserImageWithImage:cropImage];
                    }];
                    imagePicker.circleCropRadius = W_RATIO(200);
                    [imagePicker setCropViewSettingBlock:^(UIView *cropView) {
                        cropView.layer.borderColor = [UIColor whiteColor].CGColor;
                        cropView.layer.borderWidth = W_RATIO(10);
                    }];
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }];
            }];
        }];
    }
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
