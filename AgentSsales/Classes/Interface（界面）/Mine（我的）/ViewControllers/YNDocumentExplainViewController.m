//
//  YNDocumentExplainViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/22.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNDocumentExplainViewController.h"

@interface YNDocumentExplainViewController ()
{
    NSInteger _type;
}
@property (nonatomic,weak) UIWebView * webView;

@property (nonatomic,weak) WKWebView * wkWebView;
@end

@implementation YNDocumentExplainViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithcommonProblem];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithcommonProblem{
    NSDictionary *params = @{@"status":[NSNumber numberWithInteger:_status],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers commonProblemWithParams:params success:^(id response) {
        if (iOS8) {
            [self.wkWebView loadHTMLString:response baseURL:nil];
        }else{
            [self.webView loadHTMLString:response baseURL:nil];
        }
    } failure:^(NSError *error) {
    }];
}
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
        
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
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
-(UIWebView *)webView{
    if (!_webView) {
        CGRect frame = CGRectMake(0,kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
        _webView = webView;
        [self.view addSubview:webView];
        webView.scalesPageToFit = YES;
        //webView.delegate = self;
    }
    return _webView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    if (_status == 1) {
        self.titleLabel.text = kLocalizedString(@"常见问题",@"常见问题");
    }else if (_status == 2){
        self.titleLabel.text = kLocalizedString(@"分销规则",@"分销规则");
    }else if (_status == 3){
        self.titleLabel.text = kLocalizedString(@"兑换说明",@"兑换说明");
    }
}
-(void)makeUI{
    [super makeUI];
    
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
