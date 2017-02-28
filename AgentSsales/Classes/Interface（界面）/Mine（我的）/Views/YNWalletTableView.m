//
//  YNWalletTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNWalletTableView.h"

@interface YNWalletTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNWalletTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.rowHeight = W_RATIO(100);
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_FFFFFF;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
//        UIView *footerView = [[UIView alloc] init];
//        footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kMinSpace);
//        
//        self.tableFooterView = footerView;
        
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}

-(void)setItemTitles:(NSArray<NSString *> *)itemTitles{
    _itemTitles = itemTitles;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W_RATIO(84));
    headerView.backgroundColor = COLOR_FFFFFF;
    
    if (self.isHaveLine) {
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, HEIGHTF(headerView)-W_RATIO(2), WIDTHF(headerView), W_RATIO(2));
        lineView.backgroundColor = COLOR_EDEDED;
        [headerView addSubview:lineView];
    }
    
    CGFloat itemWidth = (SCREEN_WIDTH-kMidSpace*2-kMinSpace*(itemTitles.count-1))/itemTitles.count;
    [itemTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel * itemlabel = [[UILabel alloc] init];
        [headerView addSubview:itemlabel];
        itemlabel.text = title;
        itemlabel.font = FONT(26);
        itemlabel.textColor = COLOR_999999;
        itemlabel.textAlignment = NSTextAlignmentCenter;
        itemlabel.frame = CGRectMake(kMidSpace+idx*(itemWidth+kMinSpace), 0, itemWidth, HEIGHTF(headerView));
        if (idx == 0) {
            itemlabel.textAlignment = NSTextAlignmentLeft;
        }
    }];
    self.tableHeaderView = headerView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YNWalletTableViewCell * walletCell = [tableView dequeueReusableCellWithIdentifier:@"walletCell"];
    if (walletCell == nil) {
        walletCell = [[YNWalletTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"walletCell"];
        walletCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.isHaveLine) {
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(0, HEIGHTF(walletCell.contentView)-W_RATIO(2), WIDTHF(walletCell.contentView), W_RATIO(2));
            lineView.backgroundColor = COLOR_EDEDED;
            [walletCell.contentView addSubview:lineView];
        }
    }
    
    if (indexPath.row == 0) {
        walletCell.flagImgView.image = [UIImage imageNamed:@"malaixiya_guoqi"];
        walletCell.countryLabel.text = @"马来西亚币";
    }else if (indexPath.row == 1){
        walletCell.flagImgView.image = [UIImage imageNamed:@"meiguo_guoqi"];
        walletCell.countryLabel.text = @"美元";
    }
    walletCell.buyInLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"buyup"]];
    walletCell.sellOutLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"sell"]];

    return walletCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
@end

@interface YNWalletTableViewCell ()

@end

@implementation YNWalletTableViewCell

-(UIImageView *)flagImgView{
    if (!_flagImgView) {
        UIImageView *flagImgView = [[UIImageView alloc] init];
        _flagImgView = flagImgView;
        [self.contentView addSubview:flagImgView];
        flagImgView.frame = CGRectMake(kMidSpace,
                                       (HEIGHTF(self.contentView)-W_RATIO(26))/2.0,
                                       W_RATIO(40),
                                       W_RATIO(26));
    }
    return _flagImgView;
}

-(UILabel *)countryLabel{
    if (!_countryLabel) {
        UILabel *countryLabel = [[UILabel alloc] init];
        _countryLabel = countryLabel;
        [self.contentView addSubview:countryLabel];
        countryLabel.font = FONT(30);
        countryLabel.textColor = COLOR_333333;
        countryLabel.frame = CGRectMake(MaxXF(_flagImgView)+kMinSpace,
                                        0,
                                        (SCREEN_WIDTH-kMidSpace*2-kMinSpace*2)/3-WIDTHF(_flagImgView)-kMinSpace,
                                        HEIGHTF(self.contentView));
    }
    return _countryLabel;
}
-(UILabel *)buyInLabel{
    if (!_buyInLabel) {
        UILabel *buyInLabel = [[UILabel alloc] init];
        _buyInLabel = buyInLabel;
        [self.contentView addSubview:buyInLabel];
        buyInLabel.font = FONT(30);
        buyInLabel.textColor = COLOR_333333;
        buyInLabel.textAlignment = NSTextAlignmentCenter;
        buyInLabel.frame = CGRectMake(MaxXF(_countryLabel)+kMinSpace,
                                        YF(_countryLabel),
                                        (SCREEN_WIDTH-kMidSpace*2-kMinSpace*2)/3,
                                        HEIGHTF(_countryLabel));
    }
    return _buyInLabel;
}
-(UILabel *)sellOutLabel{
    if (!_sellOutLabel) {
        UILabel *sellOutLabel = [[UILabel alloc] init];
        _sellOutLabel = sellOutLabel;
        [self.contentView addSubview:sellOutLabel];
        sellOutLabel.font = FONT(30);
        sellOutLabel.textColor = COLOR_333333;
        sellOutLabel.textAlignment = NSTextAlignmentCenter;
        sellOutLabel.frame = CGRectMake(MaxXF(_buyInLabel)+kMinSpace,
                                      YF(_buyInLabel),
                                      WIDTHF(_buyInLabel),
                                      HEIGHTF(_buyInLabel));
    }
    return _sellOutLabel;
}





@end



