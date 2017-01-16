//
//  YNMineTableView.m
//  AgentSsales
//
//  Created by innofive on 16/12/29.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNMineTableView.h"

@interface YNMineTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation YNMineTableView

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @{@"image":@"shoucang_wode",@"text":@"我的收藏"},
                       @{@"image":@"fenxiao_wode",@"text":@"我的分销"},
                       @{@"image":@"qianbao_wode",@"text":@"我的钱包"},
                       @{@"image":@"youhuiquan_wode",@"text":@"我的优惠券"},
                       @{@"image":@"dizhi_wode",@"text":@"收货地址管理"},
                       @{@"image":@"erweima_wode",@"text":@"我的二维码"},
                       @{@"image":@"shezhi_wode",@"text":@"设置"}
                       ];
    }
    return _dataArray;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0,W_RATIO(500), SCREEN_WIDTH, SCREEN_HEIGHT-W_RATIO(500)-kUITabBarH);
        self.rowHeight = W_RATIO(100);
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self reloadData];
        
        UIView *footerView = [[UIView alloc] init];
        footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kMinSpace);

        self.tableFooterView = footerView;
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * mineCell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    if (mineCell == nil) {
        mineCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mineCell"];
        mineCell.textLabel.font = FONT(32);
        mineCell.textLabel.textColor = COLOR_333333;
        mineCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 0, WIDTHF(mineCell.contentView), W_RATIO(1));
        lineView.backgroundColor = COLOR_EDEDED;
        [mineCell.contentView addSubview:lineView];
    }
    mineCell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.row][@"image"]];
    mineCell.textLabel.text = _dataArray[indexPath.row][@"text"];
    return mineCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.didSelectMineTableViewCellClickBlock) {
        self.didSelectMineTableViewCellClickBlock(indexPath.row);
    }
}
@end
