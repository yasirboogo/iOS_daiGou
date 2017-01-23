//
//  YNNewsDetailHeaderView.m
//  AgentSsales
//
//  Created by innofive on 17/1/23.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsDetailHeaderView.h"

@interface YNNewsDetailHeaderView ()<UIWebViewDelegate>

@property (nonatomic,assign) CGSize newSize;

@property (nonatomic,weak) UIView * headerView;

@property (nonatomic,weak) UILabel * titleLabel;

@property (nonatomic,weak) UILabel * typeLabel;

@property (nonatomic,weak) UILabel * spaceLabel;

@property (nonatomic,weak) UILabel * timeLabel;

@property (nonatomic,weak) UIWebView * webView;

@property (nonatomic,weak) UIView * footerView;

@property (nonatomic,weak) UIButton * seeBtn;

@property (nonatomic,weak) UILabel * seeLabel;

@property (nonatomic,weak) UIButton * likeBtn;

@property (nonatomic,weak) UILabel * likeLabel;

@end

@implementation YNNewsDetailHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        self.scrollEnabled = NO;

        [self addSubview:self.headerView];
        
        NSString *htmlStr = @"“供给侧结构性改革是一场关系全局、关系长远的攻坚战。”习近平总书记在主持集体学习时，运用战略思维和辩证思维，突出问题导向，深刻论述推进供给侧结构性改革需要处理好的几个重大关系，理清了重点和难点，指明了方向和路径，为供给侧结构性改革“怎么干”提供了正确方法论。“供给侧结构性改革是一场关系全局、关系长远的攻坚战。”习近平总书记在主持集体学习时，运用战略思维和辩证思维，突出问题导向，深刻论述推进供给侧结构性改革需要处理好的几个重大关系，理清了重点和难点，指明了方向和路径，为供给侧结构性改革“怎么干”提供了正确方法论。“供给侧结构性改革是一场关系全局、关系长远的攻坚战。”习近平总书记在主持集体学习时，运用战略思维和辩证思维，突出问题导向，深刻论述推进供给侧结构性改革需要处理好的几个重大关系，理清了重点和难点，指明了方向和路径，为供给侧结构性改革“怎么干”提供了正确方法论。";
        [self.webView loadHTMLString:htmlStr baseURL:nil];
        [self addSubview:self.footerView];
    }
    return self;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.titleLabel.text = dict[@"title"];
    self.typeLabel.text = dict[@"type"];
    self.spaceLabel.text = @"|";
    self.timeLabel.text = dict[@"time"];
    
    self.seeBtn.userInteractionEnabled = NO;
    self.seeLabel.text = @"12540";
    self.likeBtn.selected = YES;
    self.likeLabel.text = @"254";
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:SCREEN_WIDTH-kMidSpace*2 font:_titleLabel.font];
    self.titleLabel.frame = CGRectMake(kMidSpace, kMidSpace, titleSize.width, titleSize.height);
    
    CGSize typeSize = [_typeLabel.text calculateHightWithFont:_typeLabel.font maxWidth:WIDTHF(_titleLabel)/2.0];
    self.typeLabel.frame = CGRectMake(XF(_titleLabel),MaxYF(_titleLabel)+W_RATIO(20), typeSize.width, typeSize.height);
    
    self.spaceLabel.frame = CGRectMake(MaxXF(_typeLabel), YF(_typeLabel), kMaxSpace, HEIGHTF(_typeLabel));
    self.timeLabel.frame = CGRectMake(MaxXF(_spaceLabel), YF(_spaceLabel), SCREEN_WIDTH-kMidSpace-MaxXF(_spaceLabel), HEIGHTF(_spaceLabel));
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MaxYF(_timeLabel)+W_RATIO(20));
    
    
    self.webView.frame = CGRectMake(0,MaxYF(_headerView), SCREEN_WIDTH, _newSize.height);
    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.scrollView.bounds =  CGRectMake(0,0, WIDTHF(self), _newSize.height);
    
    self.footerView.frame = CGRectMake(0, MaxYF(_webView),SCREEN_WIDTH, W_RATIO(100)*2+W_RATIO(10));

    
    self.frame = CGRectMake(0, 0, WIDTHF(_headerView),MaxYF(_footerView));
    self.contentSize = CGSizeMake(WIDTHF(self), HEIGHTF(self));
    
    if (self.htmlDidLoadFinish) {
        self.htmlDidLoadFinish();
    }
}

-(UIView *)headerView{
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] init];
        _headerView = headerView;
        [self addSubview:headerView];
    }
    return _headerView;
}
-(UILabel *)titleLabel{
    if (!_timeLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.headerView addSubview:titleLabel];
        titleLabel.numberOfLines = 0;
        titleLabel.font = FONT(36);
        titleLabel.textColor = COLOR_333333;
    }
    return _titleLabel;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        UILabel *typeLabel = [[UILabel alloc] init];
        _typeLabel = typeLabel;
        [self.headerView addSubview:typeLabel];
        typeLabel.font = FONT(26);
        typeLabel.textColor = COLOR_999999;
    }
    return _typeLabel;
}
-(UILabel *)spaceLabel{
    if (!_spaceLabel) {
        UILabel *spaceLabel = [[UILabel alloc] init];
        _spaceLabel = spaceLabel;
        [self.headerView addSubview:spaceLabel];
        spaceLabel.textAlignment = NSTextAlignmentCenter;
        spaceLabel.font = FONT(26);
        spaceLabel.textColor = COLOR_999999;
    }
    return _spaceLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        _timeLabel = timeLabel;
        [self.headerView addSubview:timeLabel];
        timeLabel.font = FONT(26);
        timeLabel.textColor = COLOR_999999;
    }
    return _timeLabel;
}
-(UIWebView *)webView{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] init];
        _webView = webView;
        [self addSubview:_webView];
        
        
        [webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew  context:nil];
        webView.bounds = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT/SCREEN_HEIGHT);
    }
    return _webView;
}
-(UIView *)footerView{
    if (!_footerView) {
        UIView *footerView = [[UIView alloc] init];
        _footerView = footerView;
        [self addSubview:footerView];
        
        UIView *lineView= [[UIView alloc] init];
        lineView.backgroundColor = COLOR_EDEDED;
        lineView.frame = CGRectMake(0, W_RATIO(100), SCREEN_WIDTH, W_RATIO(10));
        [footerView addSubview:lineView];
    }
    return _footerView;
}
-(UIButton *)seeBtn{
    if (!_seeBtn) {
        UIButton *seeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _seeBtn = seeBtn;
        [self.footerView addSubview:seeBtn];
        [seeBtn setBackgroundImage:[UIImage imageNamed:@"weiguan"] forState:UIControlStateNormal];
        seeBtn.frame = CGRectMake(W_RATIO(450), W_RATIO(20),kMidSpace, kMidSpace);
    }
    return _seeBtn;
}
-(UILabel *)seeLabel{
    if (!_seeLabel) {
        UILabel *seeLabel = [[UILabel alloc] init];
        _seeLabel = seeLabel;
        [self.footerView addSubview:seeLabel];
        seeLabel.font = FONT(26);
        seeLabel.textColor = COLOR_999999;
        seeLabel.frame = CGRectMake(MaxXF(_seeBtn)+kMinSpace, YF(_seeBtn), W_RATIO(100), HEIGHTF(_seeBtn));
    }
    return _seeLabel;
}
-(UIButton *)likeBtn{
    if (!_likeBtn) {
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn = likeBtn;
        [self.footerView addSubview:likeBtn];
        [likeBtn setBackgroundImage:[UIImage imageNamed:@"dianzan_kui"] forState:UIControlStateNormal];
        [likeBtn setBackgroundImage:[UIImage imageNamed:@"dianzan_hong"] forState:UIControlStateSelected];
        likeBtn.frame = CGRectMake(MaxXF(_seeLabel)+kMinSpace, YF(_seeLabel), WIDTHF(_seeBtn),HEIGHTF(_seeBtn));
    }
    return _likeBtn;
}
-(UILabel *)likeLabel{
    if (!_likeLabel) {
        UILabel *likeLabel = [[UILabel alloc] init];
        _likeLabel = likeLabel;
        [self.footerView addSubview:likeLabel];
        likeLabel.font = FONT(26);
        likeLabel.textColor = COLOR_999999;
        likeLabel.frame = CGRectMake(MaxXF(_likeBtn)+kMinSpace, YF(_likeBtn), WIDTHF(_seeLabel), HEIGHTF(_seeLabel));
    }
    return _likeLabel;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        self.newSize = [change[@"new"] CGSizeValue];
        //更新ScrollView
        [self layoutSubviews];
    }
}
-(void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}
@end
