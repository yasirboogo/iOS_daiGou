//
//  YNWebViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/23.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNWebViewController.h"


@interface YNWebViewController ()
@property (nonatomic,weak) UIWebView * webView;

@property (nonatomic,weak) WKWebView * wkWebView;
@end

@implementation YNWebViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:COLOR_DF463E];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    [self makeNavigationBar];
    [self makeUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:COLOR_CLEAR];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
#pragma mark - 视图加载
-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        //注册供js调用的方法
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        
        wkWebConfig.preferences.javaScriptEnabled = YES;//打开JavaScript交互 默认为YES
        
        CGRect frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:frame configuration:wkWebConfig];
        _wkWebView = wkWebView;
        [self.view addSubview:wkWebView];
        
        [wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [wkWebView setMultipleTouchEnabled:YES];
        [wkWebView setAutoresizesSubviews:YES];
        [wkWebView.scrollView setAlwaysBounceVertical:YES];
        
        //wkWebView.UIDelegate = self;
        //wkWebView.navigationDelegate = self;
        //wkWebView.scrollView.delegate = self;
        wkWebView.allowsBackForwardNavigationGestures =YES;//打开网页间的滑动返回
    }
    return _wkWebView;
}

#pragma mark - 视图加载

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    if (iOS8) {
        [self.wkWebView loadRequest:request];
    }else{
        [self.webView loadRequest:request];
    }
}
-(void)makeNavigationBar{

}
-(void)makeUI{
}
/** 重写，状态栏字体颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}
/** 调用，状态栏背景颜色 */
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
