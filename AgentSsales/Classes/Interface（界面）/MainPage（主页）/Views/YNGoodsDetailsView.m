//
//  YNGoodsDetailsView.m
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsDetailsView.h"
#import "ImagesPlayer.h"

@interface YNGoodsDetailsView ()<ImagesPlayerDelegae,UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_currentBtn;
}
@property (nonatomic,weak) UIView * headerView;

@property (nonatomic,weak) ImagesPlayer * imagesPlayer;

@property (nonatomic,weak) UIView * goodsInforView;

@property (nonatomic,weak) UILabel * hotLabel;

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UILabel * spaceLabel;

@property (nonatomic,weak) UIButton * shareBtn;

@property (nonatomic,weak) UILabel * detailLabel;

@property (nonatomic,weak) UIView * itemsView;

@property (nonatomic,weak) UITableView * tableView;

@property (nonatomic,weak) UITableView * selectParaView;

@end

@implementation YNGoodsDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.imageURLs = @[@"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                                @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                                @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg"];
        
        [self.tableView reloadData];
    }
    return self;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.hotLabel.text = @"热";
    self.nameLabel.text = @"米勒洗衣机/J-FYU78";
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    self.spaceLabel.text = @"|";
    self.detailLabel.text = @"放射状分割线以其特有的方向性和运动性,赋予了服装丰富的内容和表现力,通过研究放射状分割立体裁剪技术在女装中的应用,提出放射状分割在立体裁剪过程中的几个主要";
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize hotSize = [_hotLabel.text calculateHightWithFont:_hotLabel.font maxWidth:0];
    self.hotLabel.frame = CGRectMake(kMidSpace,(W_RATIO(100)-hotSize.height-kMinSpace)/2.0, hotSize.width+kMinSpace,hotSize.height+kMinSpace);
    
    CGSize nameSize = [_nameLabel.text calculateHightWithFont:_nameLabel.font maxWidth:0];
    self.nameLabel.frame = CGRectMake(MaxXF(_hotLabel)+kMinSpace,(W_RATIO(100)-nameSize.height)/2.0, nameSize.width, nameSize.height);
    
    CGSize detailSize = [_detailLabel.text calculateHightWithWidth:WIDTHF(self)-kMidSpace*2 font:_detailLabel.font];
    self.detailLabel.frame = CGRectMake(kMidSpace, MaxYF(_hotLabel)+kMidSpace, detailSize.width, detailSize.height);
    self.goodsInforView.frame = CGRectMake(0, MaxYF(_imagesPlayer), SCREEN_WIDTH, MaxYF(_detailLabel)+kMidSpace);
    
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
-(void)setImageURLs:(NSArray<NSString *> *)imageURLs{
    _imageURLs = imageURLs;
    [self.imagesPlayer addNetWorkImages:imageURLs placeholder:nil];
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
        spaceLabel.frame = CGRectMake(XF(_shareBtn)-kMinSpace,(W_RATIO(100)-W_RATIO(60))/2.0, kMinSpace, W_RATIO(60));
    }
    return _spaceLabel;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn = shareBtn;
        [self.goodsInforView addSubview:shareBtn];
        shareBtn.titleLabel.font = FONT(28);
        [shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        [shareBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(handleShareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.frame = CGRectMake(WIDTHF(self)-W_RATIO(180), kMidSpace, W_RATIO(180), W_RATIO(33));
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
-(UIView *)itemsView{
    if (!_itemsView) {
        UIView *itemsView = [[UIView alloc] init];
        _itemsView = itemsView;
        [self.headerView addSubview:itemsView];
        itemsView.backgroundColor = COLOR_FFFFFF;
        NSArray<NSString*> *itemsArrauy = @[@"图文详情",@"商品参数"];
        [itemsArrauy enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [itemsView addSubview:button];
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
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        [self addSubview:tableView];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = W_RATIO(90);
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView reloadData];
        tableView.frame = self.bounds;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = FONT(30);
        cell.textLabel.textColor = COLOR_333333;
        cell.detailTextLabel.font = FONT(28);
        cell.detailTextLabel.textColor = COLOR_666666;
    }
    cell.textLabel.text = @"洗衣机品牌";
    cell.detailTextLabel.text = @"HAIWE/海尔";
    return cell;
}
@end
