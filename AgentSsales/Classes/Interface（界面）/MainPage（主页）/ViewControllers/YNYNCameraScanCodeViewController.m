//
//  YNYNCameraScanCodeViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/22.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNYNCameraScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>  
#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>

static const CGFloat kBorderW = 100;
static const CGFloat kMargin = 30;

@interface YNYNCameraScanCodeViewController()<UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    
}
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak)   UIView *maskView;
@property (nonatomic, strong) UIView *scanWindow;
@property (nonatomic, strong) UIImageView *scanNetImageView;

@end

@implementation YNYNCameraScanCodeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [self resumeAnimation];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //这个属性必须打开否则返回的时候会出现黑边
    self.view.clipsToBounds=YES;
    //1.遮罩
    [self setupMaskView];
    //2.下边栏
    [self setupBottomBar];
    //3.提示文本
    [self setupTipTitleView];
    //4.顶部导航
    [self setupNavView];
    //5.扫描区域
    [self setupScanWindowView];
    //6.开始动画
    [self beginScanning];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resumeAnimation) name:@"EnterForeground" object:nil];
}
-(void)setupTipTitleView{
    
    //1.补充遮罩
    UIView *mask=[[UIView alloc]initWithFrame:CGRectMake(0, MaxYF(_maskView), SCREEN_WIDTH, kBorderW)];
    mask.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:mask];
    
    //2.操作提示
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WIDTHF(self.view)*0.9-kBorderW*2, SCREEN_WIDTH, kBorderW)];
    tipLabel.text = @"将取景框对准二维码，即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.numberOfLines = 2;
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
}
-(void)setupNavView{
    
    //1.返回
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(kUINavBtnWidth, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_saoyisao"] forState:UIControlStateNormal];
    backBtn.contentMode=UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //2.相册
    
    UIButton * albumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.frame = CGRectMake(kUINavBtnWidth*3, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
    [albumBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_saoyisao"] forState:UIControlStateNormal];
    albumBtn.contentMode=UIViewContentModeScaleAspectFit;
    [albumBtn addTarget:self action:@selector(myAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:albumBtn];
    
    //3.闪光灯
    
    UIButton * flashBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    flashBtn.frame = CGRectMake(kUINavBtnWidth*5, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_saoyisao"] forState:UIControlStateNormal];
    flashBtn.contentMode=UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashBtn];
    
    
}
- (void)setupMaskView
{
    UIView *mask = [[UIView alloc] init];
    _maskView = mask;
    
    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    mask.layer.borderWidth = kBorderW;
    
    mask.frame = CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH + kBorderW + kMargin , SCREEN_WIDTH + kBorderW + kMargin);
//    mask.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
//    mask.sd_y = 0;
    
    [self.view addSubview:mask];
}

- (void)setupBottomBar

{
    //1.下边栏
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.9, SCREEN_WIDTH, SCREEN_HEIGHT * 0.1)];
    bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    [self.view addSubview:bottomBar];
    
    //2.我的二维码
    UIButton * myCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    myCodeBtn.frame = CGRectMake(0,0, SCREEN_HEIGHT * 0.1*35/49, SCREEN_HEIGHT * 0.1);
    myCodeBtn.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT * 0.1/2);
    [myCodeBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_down"] forState:UIControlStateNormal];
    
    myCodeBtn.contentMode=UIViewContentModeScaleAspectFit;
    
    [myCodeBtn addTarget:self action:@selector(myCode) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:myCodeBtn];
    
    
}
- (void)setupScanWindowView
{
    CGFloat scanWindowH = SCREEN_WIDTH - kMargin * 2;
    CGFloat scanWindowW = SCREEN_WIDTH - kMargin * 2;
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, kBorderW, scanWindowW, scanWindowH)];
    _scanWindow.clipsToBounds = YES;
    [self.view addSubview:_scanWindow];
    
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    CGFloat buttonWH = 18;
    
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(MinXF(topRight), MinYF(bottomLeft), buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];
}

- (void)beginScanning
{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"再次扫描",nil];
        [alert show];
    }
}
#pragma mark-> 我的相册
-(void)myAlbum{
    NSLog(@"我的相册");
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //2.设置代理
        controller.delegate = self;
        //3.设置资源：
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //4.随便给他一个转场动画
        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:NULL];
        
    }else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
    }
    
}
#pragma mark-> imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        
        
    }];
    
    
}
#pragma mark-> 闪光灯
-(void)openFlash:(UIButton*)button{
    
    NSLog(@"闪光灯");
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
}
#pragma mark-> 我的二维码
-(void)disMiss{
    NSLog(@"返回");
    [self dismissViewControllerAnimated:NO completion:nil];
//    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark-> 我的二维码
-(void)myCode{
    
    NSLog(@"我的二维码");
//    ViewController2*vc=[[ViewController2 alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma mark-> 开关闪光灯
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}


#pragma mark 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        // 3. 要把偏移时间清零
        [_scanNetImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_scanNetImageView.layer setBeginTime:beginTime];
        
        [_scanNetImageView.layer setSpeed:1.0];
        
    }else{
        
        CGFloat scanNetImageViewH = 241;
        CGFloat scanWindowH = SCREEN_WIDTH - kMargin * 2;
        CGFloat scanNetImageViewW = WIDTHF(_scanWindow);
        
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:_scanNetImageView];
    }
    
    
    
}
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}







//@interface YNYNCameraScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//
//@property (strong, nonatomic) UIView *boxView;
//
//@property (strong, nonatomic) CALayer *scanLayer;
//
//-(BOOL)startReading;
//-(void)stopReading;
//
////捕捉会话
//@property (nonatomic, strong) AVCaptureSession *captureSession;
////展示layer
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
//
//@end
//
//@implementation YNYNCameraScanCodeViewController
//
//#pragma mark - 视图生命周期
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    self.view.backgroundColor = [UIColor colorWithHex:0x000000 andAlpha:0.8];
//}
//
//
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//}
//
//- (BOOL)startReading {
//    NSError *error;
//    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
//    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    //2.用captureDevice创建输入流
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
//    if (!input) {
//        NSLog(@"%@", [error localizedDescription]);
//        return NO;
//    }
//    //3.创建媒体数据输出流
//    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
//    //4.实例化捕捉会话
//    _captureSession = [[AVCaptureSession alloc] init];
//    //4.1.将输入流添加到会话
//    [_captureSession addInput:input];
//    //4.2.将媒体输出流添加到会话中
//    [_captureSession addOutput:captureMetadataOutput];
//    //5.创建串行队列，并加媒体输出流添加到队列当中
//    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    //5.2.设置输出媒体数据类型为QRCode
//    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
//    //6.实例化预览图层
//    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
//    //7.设置预览图层填充方式
//    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    //8.设置图层的frame
//    [_videoPreviewLayer setFrame:self.view.layer.bounds];
//    //9.将图层添加到预览view的图层上
//    [self.view.layer addSublayer:_videoPreviewLayer];
//    //10.设置扫描范围
//    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
//    //10.1.扫描框
//    _boxView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f, self.view.bounds.size.height * 0.2f, self.view.bounds.size.width - self.view.bounds.size.width * 0.4f, self.view.bounds.size.height - self.view.bounds.size.height * 0.4f)];
//    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
//    _boxView.layer.borderWidth = 1.0f;
//    [self.view addSubview:_boxView];
//    //10.2.扫描线
//    _scanLayer = [[CALayer alloc] init];
//    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
//    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
//    [_boxView.layer addSublayer:_scanLayer];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
//    [timer fire];
//    
//    //10.开始扫描
//    [_captureSession startRunning];
//    return YES;
//}
//- (void)moveScanLayer:(NSTimer *)timer
//{
//    CGRect frame = _scanLayer.frame;
//    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
//        frame.origin.y = 0;
//        _scanLayer.frame = frame;
//    }else{
//        frame.origin.y += 5;
//        [UIView animateWithDuration:0.1 animations:^{
//            _scanLayer.frame = frame;
//        }];
//    }
//}
//#pragma mark - AVCaptureMetadataOutputObjectsDelegate
//- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
//{
//    //判断是否有数据
//    if ([metadataObjects count] > 0) {
//        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
//        //判断回传的数据类型
//        if ([[metadataObject type] isEqualToString:AVMetadataObjectTypeQRCode]) {
//            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
//            NSString *stringValue = metadataObject.stringValue;
//            NSLog(@"%@",stringValue);
//        }
//    }
//}
//-(void)stopReading{
//    [_captureSession stopRunning];
//    _captureSession = nil;
//    [_scanLayer removeFromSuperlayer];
//    [_videoPreviewLayer removeFromSuperlayer];
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self startReading];
//
//}
////- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
////{
////    NSString *stringValue;
////    if ([metadataObjects count] >0){
////        //停止扫描
////        [_session stopRunning];
////        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
////        stringValue = metadataObject.stringValue;
////        NSLog(@"%@",stringValue);
////        [self playSoundEffect:@"SentMessage.caf"];
////    }
////}
//
//-(void)playSoundEffect:(NSString*)name{
//    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@",name];
//    SystemSoundID soundID = 0;
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:path]), &soundID);
//    AudioServicesPlayAlertSound(soundID);
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
@end
