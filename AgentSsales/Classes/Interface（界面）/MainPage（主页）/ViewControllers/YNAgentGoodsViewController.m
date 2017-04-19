//
//  YNAgentGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNAgentGoodsViewController.h"
#import "ObjectiveGumbo.h"
#import "OCGumbo.h"
#import "OCGumbo+Query.h"

@interface YNAgentGoodsViewController ()<WKUIDelegate,UIWebViewDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIScrollViewDelegate>
{
    UIBarButtonItem *_stopBtn;
    UIBarButtonItem *_reloadBtn;
    UIBarButtonItem *_backawayBtn;
    UIBarButtonItem *_forwardBtn;
    UIBarButtonItem *_backAppBtn;
}

@property (nonatomic,strong)NSMutableURLRequest  * request;

@property (nonatomic,strong)UIWebView  * webView;

@property (nonatomic,strong)WKWebView  * wkWebView;

@property (nonatomic,strong)WKUserContentController *userContentController;

@property (nonatomic,strong)UIButton  * buyBtn;

@property (nonatomic,strong)NSString  * getUrl;

@property (nonatomic,assign)BOOL isBuy;

@end

@implementation YNAgentGoodsViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLOR_EDEDED;
    [self setStatusBarBackgroundColor:COLOR_DF463E];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.toolbarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    [self makeNavigationBar];
    [self makeUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    [self setStatusBarBackgroundColor:COLOR_CLEAR];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_userContentController removeScriptMessageHandlerForName:@"wkWebView"];
}
#pragma mark - 网路请求

#pragma mark - 视图加载
-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        //注册供js调用的方法
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
        
        configuration.userContentController = self.userContentController;
        configuration.preferences.javaScriptEnabled = YES;//打开JavaScript交互 默认为YES
        
        CGRect frame = CGRectMake(0, kUIStatusBar, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
        _wkWebView = wkWebView;
        [self.view addSubview:wkWebView];
        
        [wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [wkWebView setMultipleTouchEnabled:YES];
        [wkWebView setAutoresizesSubviews:YES];
        [wkWebView.scrollView setAlwaysBounceVertical:YES];

        wkWebView.UIDelegate = self;
        wkWebView.navigationDelegate = self;
        wkWebView.allowsLinkPreview = YES;//允许预览链接
        wkWebView.scrollView.delegate = self;
        
    }
    return _wkWebView;
}
-(UIWebView *)webView{
    if (!_webView) {
        CGRect frame = CGRectMake(0,kUIStatusBar, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
        _webView = webView;
        [self.view addSubview:webView];
        webView.delegate = self;
    }
    return _webView;
}
#pragma mark - 代理实现
//WKWebView Delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self toggleState];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self toggleState];
    //获取网址
    //NSLog(@"backlist ===%@",webView.backForwardList.backList);
    
    //NSLog(@"forwordlst==%@",webView.backForwardList.forwardList);
    
    //NSLog(@"url===%@",webView.backForwardList.currentItem.URL);
    //self.isBuy = NO;
    self.getUrl = [NSString stringWithFormat:@"%@",webView.backForwardList.currentItem.URL];
    if ([self.getUrl hasPrefix:@"http://h5.m.taobao.com/awp/core/detail.htm?"]//天猫
        || [self.getUrl hasPrefix:@"https://ju.taobao.com/m/jusp/alone/detailwap/mtp.htm?"]//聚划算
        || [self.getUrl hasPrefix:@"https://detail.m.tmall.hk/item.htm?"]//天猫国际
        || [self.getUrl hasPrefix:@"http://m.vip.com/product"]//唯品会
        || [self.getUrl hasPrefix:@"https://item.m.jd.com/"])//京东
    {
        NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.urlStr] encoding:NSUTF8StringEncoding error:nil];
        //NSLog(@"html = %@",html);
        self.isBuy = YES;
        self.buyBtn.hidden = NO;
        //OGDocument *document = [ObjectiveGumbo parseDocumentWithUrl:[NSURL URLWithString:self.urlStr]];
        //NSLog(@"document = %@",document);
        OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString:htmlString];
        NSLog(@"text: %@", document.Query(@"title").text());
    }
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    //这里处理返回按钮.默.然后根据webView加载情况判断是否显示或隐藏.
    //self.backButton.hidden = !webView.canGoBack;
}
- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    /*
     UIWebViewNavigationTypeLinkClicked，用户触击了一个链接。
     UIWebViewNavigationTypeFormSubmitted，用户提交了一个表单。
     UIWebViewNavigationTypeBackForward，用户触击前进或返回按钮。
     UIWebViewNavigationTypeReload，用户触击重新加载的按钮。
     UIWebViewNavigationTypeFormResubmitted，用户重复提交表单
     UIWebViewNavigationTypeOther，发生其它行为。
     */
    if (navigationType == UIWebViewNavigationTypeBackForward)
    {

        return NO;
    }
    return NO;
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self toggleState];
}
//WKScriptMessageHandler Delegate(js native 交互)
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    /*
     userContentController 注册message的WKUserContentController；
     message：js传过来的数据
     id body:消息携带的信息 Allowed types are NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull.
     NSString *name:消息的名字 如aaa
     message.name  js发送的方法名称
     */
    if([message.name  isEqualToString:@"wkWebView"]){
        NSString * body = [message.body objectForKey:@"body"];
        //在这里写oc 实现协议的native方法
    }
}
//UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self toggleState];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self toggleState];
    NSLog(@"url===%@",webView.request.URL.absoluteString);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self toggleState];
}
- (void)toggleState{
    NSMutableArray *toolbarItems = [self.toolbarItems mutableCopy];
    if (iOS8) {
        _backawayBtn.enabled = self.wkWebView.canGoBack;
        _forwardBtn.enabled = self.wkWebView.canGoForward;
        if (self.wkWebView.loading) {
            toolbarItems[toolbarItems.count-2] = _stopBtn;
        }else {
            toolbarItems[toolbarItems.count-2] = _reloadBtn;
        }
    }else{
        _backawayBtn.enabled = self.webView.canGoBack;
        _forwardBtn.enabled = self.webView.canGoForward;
        if (self.webView.loading) {
            toolbarItems[toolbarItems.count-2] = _stopBtn;
        }else {
            toolbarItems[toolbarItems.count-2] = _reloadBtn;
        }
    }
    self.toolbarItems = [toolbarItems copy];
}
#pragma mark - UITableView delegate
/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isBuy) {
        if (scrollView.contentOffset.y > SCREEN_HEIGHT/2.0) {
            _buyBtn.hidden = YES;
        }else{
            _buyBtn.hidden = NO;
        }
    }
}
 */
#pragma mark - 函数、消息
-(void)makeData{
    if (iOS8) {
        [self.wkWebView loadRequest:self.request];
    }else{
        [self.webView loadRequest:self.request];
    }
    
}
-(void)makeNavigationBar{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}
-(void)makeUI{
    [self setupToolBarItems];
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
- (void)setupToolBarItems
{
    _backAppBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAppButton)];
    
    _stopBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopLoading)];
    
    _reloadBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload)];
    _backawayBtn = [[UIBarButtonItem alloc] initWithImage:[self backButtonImage] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    _forwardBtn = [[UIBarButtonItem alloc] initWithImage:[self forwardButtonImage] style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbarItems = [[NSArray alloc] initWithObjects:space,_backAppBtn,space,_backawayBtn,space,_forwardBtn,space,_stopBtn,space, nil];
    
    _backawayBtn.enabled = NO;
    _forwardBtn.enabled = NO;
}
-(void)backAppButton{
    _buyBtn.hidden = YES;
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)stopLoading{
    if (iOS8) {
        [_wkWebView stopLoading];
    }else{
        [_webView stopLoading];
    }
}
-(void)reload{
    if (iOS8) {
        [_wkWebView reload];
    }else{
        [_webView reload];
    }
}
-(void)goBack{
    _buyBtn.hidden = YES;
    if (iOS8) {
        [_wkWebView goBack];
    }else{
        [_webView goBack];
    }
}
-(void)goForward{
    if (iOS8) {
        [_wkWebView goForward];
    }else{
        [_webView goForward];
    }
}
#pragma mark - Helpers

- (UIImage *)backButtonImage
{
    static UIImage *image;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        CGSize size = CGSizeMake(12.0, 21.0);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 1.5;
        path.lineCapStyle = kCGLineCapButt;
        path.lineJoinStyle = kCGLineJoinMiter;
        [path moveToPoint:CGPointMake(11.0, 1.0)];
        [path addLineToPoint:CGPointMake(1.0, 11.0)];
        [path addLineToPoint:CGPointMake(11.0, 20.0)];
        [path stroke];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    
    return image;
}

- (UIImage *)forwardButtonImage
{
    static UIImage *image;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        UIImage *backButtonImage = [self backButtonImage];
        
        CGSize size = backButtonImage.size;
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGFloat x_mid = size.width / 2.0;
        CGFloat y_mid = size.height / 2.0;
        
        CGContextTranslateCTM(context, x_mid, y_mid);
        CGContextRotateCTM(context, M_PI);
        
        [backButtonImage drawAtPoint:CGPointMake(-x_mid, -y_mid)];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    
    return image;
}
#pragma mark - 数据懒加载
-(NSMutableURLRequest *)request{
    _request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    return _request;
}
-(WKUserContentController *)userContentController{
    if (!_userContentController) {
        _userContentController =[[WKUserContentController alloc] init];
        [_userContentController addScriptMessageHandler:self name:@"wkWebView"];//注册一个name为aaa的js方法
    }
    return _userContentController;
}
-(UIButton *)buyBtn{
    if (!_buyBtn) {
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn = buyBtn;
        [self.view addSubview:buyBtn];
        [buyBtn setTitle:@"一键购买" forState:UIControlStateNormal];
        buyBtn.backgroundColor = COLOR_DF463E;
        [buyBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(handleBuyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        buyBtn.frame = CGRectMake(0, SCREEN_HEIGHT-44-W_RATIO(120), SCREEN_WIDTH, W_RATIO(120));
        [self.view bringSubviewToFront:buyBtn];
        buyBtn.hidden = YES;
    }
    return _buyBtn;
}
-(void)handleBuyButtonClick:(UIButton*)btn{
    
}
#pragma mark - 其他

@end
