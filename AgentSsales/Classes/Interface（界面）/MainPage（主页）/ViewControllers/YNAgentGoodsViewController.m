//
//  YNAgentGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNAgentGoodsViewController.h"

@interface YNAgentGoodsViewController ()

@property (nonatomic,strong)NSMutableURLRequest  * request;

@property (nonatomic,strong)UIWebView  * webView;

@property (nonatomic,strong)WKWebView  * wkWebView;

@end

@implementation YNAgentGoodsViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLOR_EDEDED;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求

#pragma mark - 视图加载
-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:frame];
        _wkWebView = wkWebView;
        [self.view addSubview:wkWebView];
    }
    return _wkWebView;
}
-(UIWebView *)webView{
    if (!_webView) {
        CGRect frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
        _webView = webView;
        [self.view addSubview:webView];
    }
    return _webView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    if (iOS8) {
        [self.wkWebView loadRequest:self.request];
    }else{
        [self.webView loadRequest:self.request];
    }
    
}
-(void)makeNavigationBar{

}
-(void)makeUI{

}
#pragma mark - 数据懒加载
-(NSMutableURLRequest *)request{
    _request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    return _request;
}
#pragma mark - 其他

@end
