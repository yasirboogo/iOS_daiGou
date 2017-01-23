//
//  YNPaySuccessViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPaySuccessViewController.h"
#import "YNTipsSuccessTopView.h"
#import "YNTipsSuccessMsgView.h"
#import "YNTipsSuccessBtnsView.h"

#import "YNMineCouponViewController.h"
#import "YNMineWalletViewController.h"
#import "YNMineOrderViewController.h"

@interface YNPaySuccessViewController ()

@property (nonatomic,weak) YNTipsSuccessTopView * topView;

@property (nonatomic,weak) YNTipsSuccessMsgView * msgView;

@property (nonatomic,weak) YNTipsSuccessBtnsView * btnsView;

@end

@implementation YNPaySuccessViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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

#pragma mark - 视图加载
-(YNTipsSuccessTopView *)topView{
    if (!_topView) {
        YNTipsSuccessTopView *topView =[[YNTipsSuccessTopView alloc] init];
        _topView = topView;
        [self.view addSubview:topView];
    }
    return _topView;
}
-(YNTipsSuccessMsgView *)msgView{
    if (!_msgView) {
        YNTipsSuccessMsgView *msgView = [[YNTipsSuccessMsgView alloc] init];
        _msgView = msgView;
        [self.view addSubview:msgView];
    }
    return _msgView;
}
-(YNTipsSuccessBtnsView *)btnsView{
    if (!_btnsView) {
        YNTipsSuccessBtnsView *btnsView = [[YNTipsSuccessBtnsView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.btnStyle = UIButtonStyle1;
        [btnsView setDidSelectBottomButtonClickBlock:^(NSString *name) {
            [self handleBottomButtonClickWithName:name];
        }];
    }
    return _btnsView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleBottomButtonClickWithName:(NSString*)name{
    if ([name isEqualToString:@"返回首页"]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else if ([name isEqualToString:@"查看订单"]){
        YNMineOrderViewController *pushVC = [[YNMineOrderViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:NO];
    }else if ([name isEqualToString:@"查看我的钱包"]){
        YNMineWalletViewController *pushVC = [[YNMineWalletViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:NO];
    }else if ([name isEqualToString:@"查看优惠劵"]){
        YNMineCouponViewController *pushVC = [[YNMineCouponViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:NO];
    }
}

-(void)makeData{
    [super makeData];
    
    if ([self.titleStr isEqualToString:@"充值成功"]) {
        //第一部分
        self.topView.dict = @{@"image":@"chongzhichenggong",@"tips":@"恭喜你，充值成功!"};
        //第二部分
        NSString *tips = @"您充值的[200元人民币]已成功存入我的钱包，并赠送了[20元优惠劵]，请前往查看。";
        CGSize msgSize = [tips calculateHightWithWidth:WIDTHF(_topView)-kMidSpace*2 font:FONT(28)];
        
        NSMutableAttributedString *msgAttributedStrM = [[NSMutableAttributedString alloc] initWithString:tips];
        [msgAttributedStrM addAttributes:@{NSForegroundColorAttributeName:COLOR_DF463E} range:NSMakeRange(4, 9)];
        [msgAttributedStrM addAttributes:@{NSForegroundColorAttributeName:COLOR_649CE0} range:NSMakeRange(28, 7)];
        
        self.msgView.msgSize = msgSize;
        self.msgView.dict = @{@"title":@"充值成功",@"msg":msgAttributedStrM};
        //第三部分
        self.btnsView.btnTitles = @[@"查看我的钱包",@"查看优惠劵"];
    }else if ([self.titleStr isEqualToString:@"兑换成功"]){
        //第一部分
        self.topView.dict = @{@"image":@"duihuanchenggong",@"tips":@"恭喜你，兑换成功!"};
        //第二部分
        NSString *tips = @"您兑换的[231.15元美元]已成功存入我的钱包，请前往查看。";
        CGSize msgSize = [tips calculateHightWithWidth:WIDTHF(_topView)-kMidSpace*2 font:FONT(28)];
        
        NSMutableAttributedString *msgAttributedStrM = [[NSMutableAttributedString alloc] initWithString:tips];
        [msgAttributedStrM addAttributes:@{NSForegroundColorAttributeName:COLOR_DF463E} range:NSMakeRange(4, 11)];
        
        self.msgView.msgSize = msgSize;
        self.msgView.dict = @{@"title":@"兑换成功",@"msg":msgAttributedStrM};
        //第三部分
        self.btnsView.btnTitles = @[@"查看我的钱包"];
    }else if ([self.titleStr isEqualToString:@"确认收货"]){
        //第一部分
        self.topView.dict = @{@"image":@"querenshouhuo",@"tips":@"你已确定收货！"};
        //第二部分
        NSString *tips = @"你的商品已经确认收货，你可以返回首页或者查看订单详情。";
        CGSize msgSize = [tips calculateHightWithWidth:WIDTHF(_topView)-kMidSpace*2 font:FONT(28)];
        
        NSMutableAttributedString *msgAttributedStrM = [[NSMutableAttributedString alloc] initWithString:tips];
        
        self.msgView.msgSize = msgSize;
        self.msgView.dict = @{@"title":@"确认收货",@"msg":msgAttributedStrM};
        //第三部分
        self.btnsView.btnTitles = @[@"返回首页",@"查看订单"];
    }else if ([self.titleStr isEqualToString:@"支付成功"]){
        //第一部分
        self.topView.dict = @{@"image":@"zhifuchenggong",@"tips":@"恭喜你，支付成功！"};
        //第二部分
        NSString *tips = @"我们将尽快安排发货，请买家保持手机通讯通畅，以便快递小哥能第一时间联系到你。";
        CGSize msgSize = [tips calculateHightWithWidth:WIDTHF(_topView)-kMidSpace*2 font:FONT(28)];
        
        NSMutableAttributedString *msgAttributedStrM = [[NSMutableAttributedString alloc] initWithString:tips];
        
        self.msgView.msgSize = msgSize;
        self.msgView.dict = @{@"title":@"送货信息",@"msg":msgAttributedStrM};
        //第三部分
        self.btnsView.btnTitles = @[@"返回首页",@"查看订单"];
    }else if ([self.titleStr isEqualToString:@"订单提交成功"]){
        //第一部分
        self.topView.dict = @{@"image":@"dingdantijiaochengong",@"tips":@"恭喜你，订单提交成功！"};
        //第二部分
        NSString *tips = @"代购订单需要确认邮费及关税后才能付款，处理需要1到3个工作日";
        CGSize msgSize = [tips calculateHightWithWidth:WIDTHF(_topView)-kMidSpace*2 font:FONT(28)];
        
        NSMutableAttributedString *msgAttributedStrM = [[NSMutableAttributedString alloc] initWithString:tips];
        
        self.msgView.msgSize = msgSize;
        self.msgView.dict = @{@"title":@"代购说明",@"msg":msgAttributedStrM};
        //第三部分
        self.btnsView.btnTitles = @[@"返回首页",@"查看订单"];
    }
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = self.titleStr;
}
-(void)makeUI{
    [super makeUI];

}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
