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

@property (nonatomic,weak) YNWebHeaderView * headerView;

@property (nonatomic,weak) UIWebView * webView;

@property (nonatomic,weak) YNWebFooterView * footerView;

@end

@implementation YNNewsDetailHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        self.scrollEnabled = NO;
    }
    return self;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

    self.headerView.dict = dict;
    
    NSString *htmlStr = dict[@"content"];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    
    _footerView.dict = dict;
    _footerView.commentNum = _commentNum;
    [_footerView setDidSelectLikeButtonBlock:^(BOOL isLike) {
        self.didSelectLikeButtonBlock(isLike);
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];

    self.webView.frame = CGRectMake(0,W_RATIO(200), SCREEN_WIDTH, _newSize.height);
    self.webView.scrollView.scrollEnabled = NO;
    
    self.footerView.frame = CGRectMake(0, MaxYF(_webView),SCREEN_WIDTH, W_RATIO(100)*2+W_RATIO(10));

    self.frame = CGRectMake(0, 0, WIDTHF(_headerView),(int)MaxYF(_footerView));
    self.contentSize = CGSizeMake(WIDTHF(self), HEIGHTF(self));
    
    if (self.htmlDidLoadFinish) {
        self.htmlDidLoadFinish();
    }
}
-(YNWebHeaderView *)headerView{
    if (!_headerView) {
        YNWebHeaderView *headerView = [[YNWebHeaderView alloc] init];
        _headerView = headerView;
        [self addSubview:headerView];
    }
    return _headerView;
}

-(UIWebView *)webView{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] init];
        _webView = webView;
        [self addSubview:_webView];
        
        [webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew  context:nil];
        webView.frame = CGRectMake(0,MaxYF(_headerView), SCREEN_WIDTH, SCREEN_HEIGHT/SCREEN_HEIGHT);
    }
    return _webView;
}
-(YNWebFooterView *)footerView{
    if (!_footerView) {
        CGRect frame = CGRectMake(0, MaxYF(self.webView),SCREEN_WIDTH, W_RATIO(100)*2+W_RATIO(10));
        YNWebFooterView *footerView = [[YNWebFooterView alloc] initWithFrame:frame];
        _footerView = footerView;
        [self addSubview:footerView];
    }
    return _footerView;
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

@interface YNWebHeaderView ()

@property (nonatomic,weak) UILabel * titleLabel;

@property (nonatomic,weak) UILabel * typeLabel;

@property (nonatomic,weak) UILabel * spaceLabel;

@property (nonatomic,weak) UILabel * timeLabel;
@end

@implementation YNWebHeaderView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
     self.titleLabel.text = dict[@"title"];
     self.typeLabel.text = dict[@"name"];
     self.spaceLabel.text = @"|";
     self.timeLabel.text = dict[@"createtime"];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:SCREEN_WIDTH-kMidSpace*2 font:_titleLabel.font];
    self.titleLabel.frame = CGRectMake(kMidSpace, kMidSpace, titleSize.width, titleSize.height);
    
    CGSize typeSize = [_typeLabel.text calculateHightWithFont:_typeLabel.font maxWidth:WIDTHF(_titleLabel)/2.0];
    self.typeLabel.frame = CGRectMake(XF(_titleLabel),MaxYF(_titleLabel)+W_RATIO(20), typeSize.width, typeSize.height);
    
    self.spaceLabel.frame = CGRectMake(MaxXF(_typeLabel), YF(_typeLabel), kMaxSpace, HEIGHTF(_typeLabel));
    self.timeLabel.frame = CGRectMake(MaxXF(_spaceLabel), YF(_spaceLabel), SCREEN_WIDTH-kMidSpace-MaxXF(_spaceLabel), HEIGHTF(_spaceLabel));
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, MaxYF(_timeLabel)+W_RATIO(20));
}
-(UILabel *)titleLabel{
    if (!_timeLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self addSubview:titleLabel];
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
        [self addSubview:typeLabel];
        typeLabel.font = FONT(26);
        typeLabel.textColor = COLOR_999999;
    }
    return _typeLabel;
}
-(UILabel *)spaceLabel{
    if (!_spaceLabel) {
        UILabel *spaceLabel = [[UILabel alloc] init];
        _spaceLabel = spaceLabel;
        [self addSubview:spaceLabel];
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
        [self addSubview:timeLabel];
        timeLabel.font = FONT(26);
        timeLabel.textColor = COLOR_999999;
    }
    return _timeLabel;
}

@end
@interface YNWebFooterView ()
@property (nonatomic,weak) UIButton * seeBtn;

@property (nonatomic,weak) UILabel * seeLabel;

@property (nonatomic,weak) UIButton * likeBtn;

@property (nonatomic,weak) UILabel * likeLabel;

@property (nonatomic,weak) UIView * lineView;

@property (nonatomic,weak) UIImageView * comImgView;

@property (nonatomic,weak) UILabel * comLabel;

@property (nonatomic,weak) UILabel * comNumLabel;

@end

@implementation YNWebFooterView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

    self.seeBtn.userInteractionEnabled = NO;
    self.seeLabel.text = [NSString stringWithFormat:@"%@",dict[@"number"]];
    NSString *isLike = [NSString stringWithFormat:@"%@",dict[@"islike"] ];
    self.likeBtn.selected =  [isLike boolValue];
    self.likeLabel.text = [NSString stringWithFormat:@"%@",dict[@"thumb"]];
    self.comLabel.text = @"评论";
}
-(void)setCommentNum:(NSString *)commentNum{
    _commentNum = commentNum;
    self.comNumLabel.text = [NSString stringWithFormat:@"(%@)",commentNum];
    [self layoutSubviews];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.seeBtn.frame = CGRectMake(W_RATIO(450), W_RATIO(20),kMidSpace, kMidSpace);
    self.seeLabel.frame = CGRectMake(MaxXF(_seeBtn)+kMinSpace, YF(_seeBtn), W_RATIO(100), HEIGHTF(_seeBtn));
    self.likeBtn.frame = CGRectMake(MaxXF(_seeLabel)+kMinSpace, YF(_seeLabel), WIDTHF(_seeBtn),HEIGHTF(_seeBtn));
    self.likeLabel.frame = CGRectMake(MaxXF(_likeBtn)+kMinSpace, YF(_likeBtn), WIDTHF(_seeLabel), HEIGHTF(_seeLabel));
    self.lineView.frame = CGRectMake(0, W_RATIO(100), SCREEN_WIDTH, W_RATIO(10));
    self.comImgView.frame = CGRectMake(W_RATIO(30), MaxYF(_lineView)+W_RATIO(40), W_RATIO(30), W_RATIO(30));
    CGSize comSize = [_comLabel.text calculateHightWithFont:_comLabel.font maxWidth:0];
    self.comLabel.frame = CGRectMake(MaxXF(_comImgView)+W_RATIO(30), MidYF(_comImgView)-comSize.height/2.0, comSize.width, comSize.height);
    
    CGSize comNumSize = [_comNumLabel.text calculateHightWithFont:_comNumLabel.font maxWidth:0];
    self.comNumLabel.frame = CGRectMake(MaxXF(_comLabel)+kMinSpace, MidYF(_comImgView)-comNumSize.height/2.0, comNumSize.width, comNumSize.height);
}
-(UIButton *)seeBtn{
    if (!_seeBtn) {
        UIButton *seeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _seeBtn = seeBtn;
        [self addSubview:seeBtn];
        [seeBtn setBackgroundImage:[UIImage imageNamed:@"weiguan"] forState:UIControlStateNormal];
    }
    return _seeBtn;
}
-(UILabel *)seeLabel{
    if (!_seeLabel) {
        UILabel *seeLabel = [[UILabel alloc] init];
        _seeLabel = seeLabel;
        [self addSubview:seeLabel];
        seeLabel.font = FONT(26);
        seeLabel.textColor = COLOR_999999;
    }
    return _seeLabel;
}
-(UIButton *)likeBtn{
    if (!_likeBtn) {
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn = likeBtn;
        [self addSubview:likeBtn];
        [likeBtn addTarget:self action:@selector(handleLikeButton:) forControlEvents:UIControlEventTouchUpInside];
        [likeBtn setBackgroundImage:[UIImage imageNamed:@"dianzan_kui"] forState:UIControlStateNormal];
        [likeBtn setBackgroundImage:[UIImage imageNamed:@"dianzan_hong"] forState:UIControlStateSelected];
    }
    return _likeBtn;
}
-(void)handleLikeButton:(UIButton*)btn{
    if (self.didSelectLikeButtonBlock) {
        self.didSelectLikeButtonBlock(self.likeBtn.selected);
    }
}
-(UILabel *)likeLabel{
    if (!_likeLabel) {
        UILabel *likeLabel = [[UILabel alloc] init];
        _likeLabel = likeLabel;
        [self addSubview:likeLabel];
        likeLabel.font = FONT(26);
        likeLabel.textColor = COLOR_999999;
    }
    return _likeLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        UIView *lineView = [[UIView alloc] init];
        _lineView = lineView;
        lineView.backgroundColor = COLOR_EDEDED;
        [self addSubview:lineView];
    }
    return _lineView;
}
-(UIImageView *)comImgView{
    if (!_comImgView) {
        UIImageView *comImgView = [[UIImageView alloc] init];
        _comImgView = comImgView;
        [self addSubview:comImgView];
        comImgView.image = [UIImage imageNamed:@"quanquan_pinglun"];
    }
    return _comImgView;
}
-(UILabel *)comLabel{
    if (!_comLabel) {
        UILabel *comLabel = [[UILabel alloc] init];
        _comLabel = comLabel;
        [self addSubview:comLabel];
        comLabel.font = FONT(32);
        comLabel.textColor = COLOR_333333;
    }
    return _comLabel;
}
-(UILabel *)comNumLabel{
    if (!_comNumLabel) {
        UILabel *comNumLabel = [[UILabel alloc] init];
        _comNumLabel = comNumLabel;
        [self addSubview:comNumLabel];
        comNumLabel.font = FONT(28);
        comNumLabel.textColor = COLOR_666666;
    }
    return _comNumLabel;
}
@end
