//
//  YNGoodsCartTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsCartTableView.h"

@interface YNGoodsCartTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNGoodsCartTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.rowHeight = W_RATIO(280);
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNGoodsCartCell * cartCell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    if (cartCell == nil) {
        cartCell = [[YNGoodsCartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cartCell"];
    }
        cartCell.backgroundColor = [UIColor colorWithRandom];
    return cartCell;
}
@end
@interface YNGoodsCartCell ()
/** 勾选按钮 */
@property (nonatomic,weak) UIButton * selectBtn;
/** 背景 */
@property (nonatomic,weak) UIView * bgView;
/** 左边图片 */
@property (nonatomic,weak) UIImageView * leftImgView;
/** 标题 */
@property (nonatomic,weak) UILabel * titleLabel;
/** 版本 */
@property (nonatomic,weak) UILabel * versionLabel;
/** ￥符号 */
@property (nonatomic,weak) UILabel * markLabel;
/** 价钱 */
@property (nonatomic,weak) UILabel * priceLabel;
/** 数量 */
@property (nonatomic,weak) UILabel * amountLabel;
/** 减按钮 */
@property (nonatomic,weak) UIButton * subBtn;
/** 加按钮 */
@property (nonatomic,weak) UIButton * addBtn;
@end
@implementation YNGoodsCartCell
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    //不同模式控件布局
//    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:WIDTHF(_bgView)-MaxXF(_leftImgView)-W_RATIO(20)*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
//    _titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20), W_RATIO(20)*2, titleSize.width,titleSize.height);
//    
//    CGSize versionSize = [_versionLabel.text calculateHightWithWidth:WIDTHF(_titleLabel) font:_versionLabel.font line:_versionLabel.numberOfLines];
//    _versionLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace, versionSize.width,versionSize.height);
//    
//    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
//    _priceLabel.frame = CGRectMake(WIDTHF(_bgView)-kMidSpace-priceSize.width,YF(_invalidLabel), priceSize.width,HEIGHTF(_invalidLabel));
//    
//    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
//    self.markLabel.frame = CGRectMake(XF(_priceLabel)-markSize.width,MaxYF(_priceLabel)-markSize.height, markSize.width,markSize.height);
//    
//}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn = selectBtn;
        [self.contentView addSubview:selectBtn];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_kui_gouwuche"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_hong_gouwuche"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(handleCellSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        selectBtn.frame = CGRectMake((W_RATIO(80)-W_RATIO(60))/2.0, W_RATIO(20)+(W_RATIO(260)-W_RATIO(60))/2.0, W_RATIO(60), W_RATIO(60));
    }
    return _selectBtn;
}
-(void)handleCellSelectButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
//    if (self.didSelectedButtonClickBlock) {
//        self.didSelectedButtonClickBlock(btn.selected);
//    }
    
}
-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView= bgView;
        [self.contentView addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
        bgView.frame = CGRectMake(W_RATIO(80), W_RATIO(20), W_RATIO(650), W_RATIO(260));
        bgView.layer.cornerRadius = W_RATIO(20);
        bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView * leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        [self.bgView addSubview:leftImgView];
        leftImgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), W_RATIO(220), W_RATIO(220));
    }
    return _leftImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel * titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.bgView addSubview:titleLabel];
        titleLabel.font = FONT(32);
        titleLabel.numberOfLines = 1;
        titleLabel.textColor = COLOR_333333;
    }
    return _titleLabel;
}
-(UILabel *)versionLabel{
    if (!_versionLabel) {
        UILabel * versionLabel = [[UILabel alloc] init];
        _versionLabel = versionLabel;
        [self.bgView addSubview:versionLabel];
        versionLabel.font = FONT(26);
        versionLabel.textColor = COLOR_999999;
        versionLabel.numberOfLines = 2;
    }
    return _versionLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel * priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgView addSubview:priceLabel];
        priceLabel.font = FONT(38);
        priceLabel.textColor = COLOR_666666;
    }
    return _priceLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgView addSubview:markLabel];
        markLabel.font = FONT(26);
        markLabel.text = NSLS(@"moneySymbol", @"货币符号");
        markLabel.textColor = COLOR_666666;
    }
    return _markLabel;
}
-(UILabel *)amountLabel{
    if (_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] init];
        _amountLabel = amountLabel;
        [self.bgView addSubview:amountLabel];
        amountLabel.font = FONT(40);
        amountLabel.textColor = COLOR_666666;
    }
    return _amountLabel;
}
-(UIButton *)subBtn{
    if (_subBtn) {
        UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn = subBtn;
        [self.contentView addSubview:subBtn];
        [subBtn setBackgroundImage:[UIImage imageNamed:@"jian_qiankui_gouwuche"] forState:UIControlStateNormal];
        [subBtn addTarget:self action:@selector(handleCellSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        subBtn.frame = CGRectMake((W_RATIO(80)-W_RATIO(60))/2.0, W_RATIO(20)+(W_RATIO(260)-W_RATIO(60))/2.0, W_RATIO(60), W_RATIO(60));
    }
    return _subBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn = addBtn;
        [self.contentView addSubview:addBtn];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"jia_shenkui_gouwuche"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(handleCellSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.frame = CGRectMake((W_RATIO(80)-W_RATIO(60))/2.0, W_RATIO(20)+(W_RATIO(260)-W_RATIO(60))/2.0, W_RATIO(60), W_RATIO(60));
    }
    return _addBtn;
}
@end
