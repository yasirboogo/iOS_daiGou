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
#import "YNRegisterViewController.h"

@interface YNYNCameraScanCodeViewController()<UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate >{
    
    
}
@property (nonatomic, strong) AVCaptureSession *session;
//背景
@property (nonatomic, weak)   UIView *maskView;
//扫描窗口
@property (nonatomic, strong) UIView *scanWindow;
//扫描线
@property (nonatomic, strong) UIImageView *scanNetImageView;
//导航栏
@property (nonatomic, strong) UIView *navView;
//提示语
@property (nonatomic, strong) UILabel *tipsLabel;
@end

@implementation YNYNCameraScanCodeViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden=YES;
    [self resumeAnimation];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self beginScanning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden=NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)makeUI{
    [self.view addSubview:self.scanWindow];
    [self.view addSubview:self.maskView];
    [self.maskView addSubview:self.navView];
    [self.maskView addSubview:self.tipsLabel];
    
}
#pragma mark - 网路请求

#pragma mark - 视图加载
-(UIView *)maskView{
    if (!_maskView) {
        UIView *maskView = [[UIView alloc] init];
        _maskView = maskView;
        [self.view addSubview:maskView];
        maskView.layer.masksToBounds = YES;
        maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //背景
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:maskView.bounds cornerRadius:0];
        //镂空
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:_scanWindow.frame];
        [path appendPath:circlePath];
        [path setUsesEvenOddFillRule:YES];
        
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.path = path.CGPath;
        fillLayer.fillRule = kCAFillRuleEvenOdd;
        fillLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor;
        [maskView.layer addSublayer:fillLayer];
    }
    return _maskView;
}
-(UIView *)scanWindow{
    if (!_scanWindow) {
        UIView *scanWindow = [[UIView alloc] init];
        scanWindow.frame = CGRectMake(W_RATIO(135), W_RATIO(200), W_RATIO(480), W_RATIO(480));
        _scanWindow = scanWindow;
        [self.view addSubview:scanWindow];
        scanWindow.layer.masksToBounds = YES;
        scanWindow.backgroundColor = COLOR_CLEAR;
        }
    return _scanWindow;
}
-(UIImageView *)scanNetImageView{
    if (!_scanNetImageView) {
        _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"saomiaotiao"]];
    }
    return _scanNetImageView;
}
-(UIView *)navView{
    if (!_navView) {
        UIView *navView = [[UIView alloc] init];
        _navView = navView;
        [self.maskView addSubview:navView];
        navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kUINavHeight);
        //返回
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(kUINavBtnWidth, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_saoyisao"] forState:UIControlStateNormal];
        backBtn.contentMode=UIViewContentModeScaleAspectFit;
        [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:backBtn];
    }
    return _navView;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self.maskView addSubview:tipsLabel];
        tipsLabel.font = FONT(34);
        tipsLabel.numberOfLines = 0;
        tipsLabel.textColor = COLOR_B5B5B5;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.text = @"将二维码放入框内，可自动扫描";
        CGSize tipsSize = [tipsLabel.text calculateHightWithWidth:WIDTHF(_scanWindow) font:tipsLabel.font];
        tipsLabel.frame = CGRectMake(XF(_scanWindow), MaxYF(_scanWindow)+kMidSpace, tipsSize.width, tipsSize.height);
    }
    return _tipsLabel;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)backButtonClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - 数据懒加载

#pragma mark - 其他
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
    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.bounds];
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
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKeychainService];
        if (keychain.allItems[0][@"key"]) {
            [SVProgressHUD showImage:nil status:metadataObject.stringValue];
            [SVProgressHUD dismissWithDelay:2.0f];
        }else{
            YNRegisterViewController *pushVC = [[YNRegisterViewController alloc] init];
            pushVC.parentId = metadataObject.stringValue;
            [self presentViewController:pushVC animated:NO completion:nil];
        }
    }
}
#pragma mark 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anim = [self.scanNetImageView.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        // 3. 要把偏移时间清零
        [_scanNetImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_scanNetImageView.layer setBeginTime:beginTime];
        
        [_scanNetImageView.layer setSpeed:2.0];
        
    }else{
        CGFloat scanNetImageViewH = W_RATIO(20);
        CGFloat scanNetImageViewW = WIDTHF(_scanWindow);
        CGFloat scanWindowH = WIDTHF(_scanWindow);
        
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 2.0;
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
@end
