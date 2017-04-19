//
//  YNGoodsDetailsView.m
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsDetailsView.h"
#import "ImagesPlayer.h"
#import "YNImageSize.h"
@interface YNGoodsDetailsView ()<ImagesPlayerDelegae,UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_currentBtn;
}
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSArray * detailUrls;

@property (nonatomic,weak) UIView * headerView;

@property (nonatomic,weak) ImagesPlayer * imagesPlayer;

@property (nonatomic,weak) UIView * goodsInforView;

@property (nonatomic,weak) UILabel * hotLabel;

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UILabel * spaceLabel;

@property (nonatomic,weak) UIView * spaceView;

@property (nonatomic,weak) UIButton * shareBtn;

@property (nonatomic,weak) UILabel * detailLabel;

@property (nonatomic,weak) UILabel * msgLabel;

@property (nonatomic,weak) UIView * itemsView;

@property (nonatomic,weak) UIView * itemDetailView;

@property (nonatomic,weak) UITableView * tableView;

@property (nonatomic,weak) UITableView * selectParaView;

@end

@implementation YNGoodsDetailsView

-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    self.hotLabel.text = LocalHot;
    self.nameLabel.text = dataDict[@"name"];
    [self.shareBtn setTitle:LocalShare forState:UIControlStateNormal];
    self.spaceView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.detailLabel.text = dataDict[@"note"];

    if ([dataDict[@"isdelete"] integerValue]) {
        self.msgLabel.text = LocalShelf;
    }else if ([dataDict[@"stock"] integerValue]<1){
        self.msgLabel.text = LocalStock;
    }
    self.index = 0;
    [self.imagesPlayer addNetWorkImages:dataDict[@"imgArray"] placeholder:[UIImage imageNamed:@"zhanwei2"]];
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    if (index == 0) {
        self.detailUrls = [YNDetailImgCellFrame initWithFromDictionaries:_dataDict[@"imgdetails"]];
    }else if (index == 1){
        self.detailUrls = [YNDetailImgCellFrame initWithFromDictionaries:@[_dataDict[@"paraimg"]]];
    }

    [self.tableView reloadData];
}
-(void)layoutSubviews{
    [super layoutSubviews];

    CGSize hotSize = [_hotLabel.text calculateHightWithFont:_hotLabel.font maxWidth:0];
    self.hotLabel.frame = CGRectMake(kMidSpace,(W_RATIO(100)-hotSize.height-kMinSpace)/2.0, hotSize.width+kMinSpace,hotSize.height+kMinSpace);
    
    CGSize nameSize = [_nameLabel.text calculateHightWithWidth:W_RATIO(450) font:_nameLabel.font];
    self.nameLabel.frame = CGRectMake(MaxXF(_hotLabel)+kMinSpace,YF(_hotLabel), nameSize.width, nameSize.height);
    
    CGSize detailSize = [_detailLabel.text calculateHightWithWidth:WIDTHF(self)-kMidSpace*2 font:_detailLabel.font];
    self.detailLabel.frame = CGRectMake(kMidSpace, MaxYF(_nameLabel)+kMidSpace, detailSize.width, detailSize.height);
    
    CGSize msgSize = [_msgLabel.text calculateHightWithWidth:WIDTHF(self)-kMidSpace*2 font:_msgLabel.font];
    if (_msgLabel.text.length) {
        self.msgLabel.frame = CGRectMake(kMidSpace, MaxYF(_detailLabel)+kMidSpace, msgSize.width, msgSize.height);
    }else{
        self.msgLabel.frame = CGRectMake(kMidSpace, MaxYF(_detailLabel), 0, 0);
    }
    
    
    self.goodsInforView.frame = CGRectMake(0, MaxYF(_imagesPlayer), SCREEN_WIDTH, MaxYF(_msgLabel)+kMidSpace);
    
    self.itemsView.frame = CGRectMake(0, MaxYF(_goodsInforView)+W_RATIO(2), SCREEN_WIDTH, W_RATIO(80));
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MaxYF(_itemsView));
    
    self.tableView.tableHeaderView = self.headerView;

}
-(UIView *)headerView{
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] init];
        _headerView = headerView;
        self.tableView.tableHeaderView = headerView;
        headerView.backgroundColor = COLOR_EDEDED;
    }
    return _headerView;
}
-(ImagesPlayer *)imagesPlayer{
    if (!_imagesPlayer) {
        ImagesPlayer *imagesPlayer = [[ImagesPlayer alloc] init];
        _imagesPlayer = imagesPlayer;
        [self.headerView addSubview:imagesPlayer];
        imagesPlayer.frame = CGRectMake(0, 0, WIDTHF(self), W_RATIO(560));
        imagesPlayer.delegate = self;
        imagesPlayer.autoScroll = NO;
        imagesPlayer.indicatorView.currentPageIndicatorTintColor = COLOR_DF463E;
        imagesPlayer.indicatorView.pageIndicatorTintColor = COLOR_FFFFFF;
    }
    return _imagesPlayer;
}
#pragma mark 广告页ImagesPlayerDelegae
- (void)imagesPlayer:(ImagesPlayer *)player didSelectImageAtIndex:(NSInteger)index
{
    if (self.didSelectPlayerImgClickBlock) {
        self.didSelectPlayerImgClickBlock([NSString stringWithFormat:@"你点击第%ld个广告页",(long)index]);
    }
}

-(UIView *)goodsInforView{
    if (!_goodsInforView) {
        UIView *goodsInforView = [[UIView alloc] init];
        _goodsInforView = goodsInforView;
        [self.headerView addSubview:goodsInforView];
        goodsInforView.backgroundColor = COLOR_FFFFFF;
        
    }
    return _goodsInforView;
}
-(UILabel *)hotLabel{
    if (!_hotLabel) {
        UILabel *hotLabel = [[UILabel alloc] init];
        _hotLabel = hotLabel;
        [self.goodsInforView addSubview:hotLabel];
        hotLabel.textAlignment = NSTextAlignmentCenter;
        hotLabel.textColor = COLOR_FFFFFF;
        hotLabel.backgroundColor = COLOR_DF463E;
        hotLabel.font = FONT(24);
        hotLabel.layer.masksToBounds = YES;
        hotLabel.layer.cornerRadius = W_RATIO(6);
    }
    return _hotLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.goodsInforView addSubview:nameLabel];
        nameLabel.textColor = COLOR_333333;
        nameLabel.font = FONT(34);
        nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
-(UILabel *)spaceLabel{
    if (!_spaceLabel) {
        UILabel *spaceLabel = [[UILabel alloc] init];
        _spaceLabel = spaceLabel;
        [self.goodsInforView addSubview:spaceLabel];
        spaceLabel.textColor = COLOR_999999;
        spaceLabel.font = FONT(60);
        spaceLabel.textAlignment = NSTextAlignmentCenter;
        spaceLabel.frame = CGRectMake(XF(_shareBtn)-kMinSpace,(W_RATIO(100)-W_RATIO(50))/2.0, kMinSpace, W_RATIO(50));
    }
    return _spaceLabel;
}
-(UIView *)spaceView{
    if (!_spaceView) {
        UIView *spaceView = [[UIView alloc] init];
        _spaceView = spaceView;
        [self.goodsInforView addSubview:spaceView];
        spaceView.frame = CGRectMake(XF(_shareBtn)-kMinSpace,YF(_shareBtn), W_RATIO(4), HEIGHTF(_shareBtn));
    }
    return _spaceView;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn = shareBtn;
        [self.goodsInforView addSubview:shareBtn];
        shareBtn.titleLabel.font = FONT(28);
        [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -W_RATIO(20), 0, 0)];
        [shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        [shareBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(handleShareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.frame = CGRectMake(WIDTHF(self)-W_RATIO(180), W_RATIO(25), W_RATIO(180), W_RATIO(50));
    }
    return _shareBtn;
}
-(void)handleShareButtonClick:(UIButton*)btn{
    if (self.didSelectShareButtonClickBlock) {
        self.didSelectShareButtonClickBlock();
    }
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *detailLabel = [[UILabel alloc] init];
        _detailLabel = detailLabel;
        [self.goodsInforView addSubview:detailLabel];
        detailLabel.textColor = COLOR_999999;
        detailLabel.font = FONT(28);
        detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
-(UILabel *)msgLabel{
    if (!_msgLabel) {
        UILabel *msgLabel = [[UILabel alloc] init];
        _msgLabel = msgLabel;
        [self.goodsInforView addSubview:msgLabel];
        msgLabel.textColor = COLOR_FF4844;
        msgLabel.font = FONT(28);
        msgLabel.numberOfLines = 0;
    }
    return _msgLabel;
}
-(UIView *)itemsView{
    if (!_itemsView) {
        UIView *itemsView = [[UIView alloc] init];
        _itemsView = itemsView;
        [self.headerView addSubview:itemsView];
        itemsView.backgroundColor = COLOR_FFFFFF;
        NSArray<NSString*> *itemsArrauy = @[LocalImageDetail,LocalGoodsPara];
        [itemsArrauy enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [itemsView addSubview:button];
            button.tag = idx;
            button.titleLabel.font =FONT(30);
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:COLOR_666666 forState:UIControlStateNormal];
            [button setTitleColor:COLOR_DF463E forState:UIControlStateSelected];
            [button addTarget:self action:@selector(handleScrollButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(idx*SCREEN_WIDTH/itemsArrauy.count, 0, SCREEN_WIDTH/itemsArrauy.count,W_RATIO(80));
            if (idx == 0) {
                button.selected = YES;
                _currentBtn = button;
            }
        }];
    }
    return _itemsView;
}
-(void)handleScrollButtonClick:(UIButton*)btn{
    _currentBtn.selected = NO;
    _currentBtn = btn;
    _currentBtn.selected = YES;
    
    self.index = btn.tag;
}
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        [self addSubview:tableView];
        tableView.frame = self.bounds;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView reloadData];
        tableView.frame = self.bounds;
        tableView.tableHeaderView = self.headerView;
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.index == 0) {
        return self.detailUrls.count+1;
    }else if (self.index == 1){
        return 2;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([_dataDict[@"isvideo"] integerValue]==1 & self.index == 0) {
            return SCREEN_WIDTH/2.0;
        }
        return kZero;
    }else{
        YNDetailImgCellFrame *cellFrame = self.detailUrls[indexPath.row - 1];
        return cellFrame.cellHeight;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YNDetailVideoCell *videoCell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
        if (!videoCell) {
            videoCell = [[YNDetailVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"videoCell"];
        }
        videoCell.videoUrl = @"about:blank";
        if ([_dataDict[@"isvideo"] integerValue]==1 && self.index == 0) {
            videoCell.videoUrl = _dataDict[@"videourl"];
        }
        return videoCell;
    }else{
        YNDetailImgCell * imgCell = [tableView dequeueReusableCellWithIdentifier:@"imgCell1"];
        if (imgCell == nil) {
            imgCell = [[YNDetailImgCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"imgCell"];
            imgCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        YNDetailImgCellFrame *cellFrame = self.detailUrls[indexPath.row - 1];
        imgCell.cellFrame = cellFrame;
        return imgCell;
    }
    return nil;
}
@end






@implementation YNDetailImgCellFrame
-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    CGSize imgSize = [YNImageSize calculateImageSizeWithURL:imgUrl];
    self.cellHeight = imgSize.height / imgSize.width * W_RATIO(750);
}
+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array{
    
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithArray:array];
    
    NSMutableArray *endArray = [NSMutableArray array];
    
    [tempArrayM enumerateObjectsUsingBlock:^(NSString *imgUrl, NSUInteger idx, BOOL * _Nonnull stop) {
        YNDetailImgCellFrame *cellFrame = [[YNDetailImgCellFrame alloc] init];
        cellFrame.imgUrl = imgUrl;
        [endArray addObject:cellFrame];
    }];
    return endArray;
}
@end
@interface YNDetailImgCell()

@end
@implementation YNDetailImgCell

-(void)setCellFrame:(YNDetailImgCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    self.bgImgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, cellFrame.cellHeight);
    
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:cellFrame.imgUrl] placeholderImage:[UIImage imageNamed:@"zhanwei2"]];
}
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        UIImageView *bgImgView = [[UIImageView alloc] init];
        _bgImgView = bgImgView;
        [self.contentView addSubview:bgImgView];
    }
    return _bgImgView;
}
@end

@interface YNDetailVideoCell ()

@property (nonatomic,strong) WKWebView * wKWebView;

@end
@implementation YNDetailVideoCell

-(void)setVideoUrl:(NSString *)videoUrl{
    _videoUrl = videoUrl;
    if (![videoUrl isEqualToString:@"about:blank"]) {
        self.wKWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2.0);
    }else{
        self.wKWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kZero);
    }
    [self.wKWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:videoUrl]]];
}
-(WKWebView *)wKWebView{
    if (!_wKWebView) {
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
        configuration.mediaPlaybackRequiresUserAction = YES;
        WKWebView *wKWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _wKWebView = wKWebView;
        [self.contentView addSubview:wKWebView];
        wKWebView.scrollView.bounces = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCloseVideo) name:@"closeVideo" object:nil];
    }
    return _wKWebView;
}
-(void)handleCloseVideo{
    self.videoUrl = @"about:blank";
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
