//
//  YNSelectMoneyTypeTableView.m
//  AgentSsales
//
//  Created by innofive on 17/3/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSelectMoneyTypeTableView.h"

@interface YNSelectMoneyTypeTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNSelectMoneyTypeTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = COLOR_999999;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.rowHeight = W_RATIO(80);
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = FONT(30);
        cell.backgroundColor = COLOR_CLEAR;

        cell.tintColor = COLOR_333333;
    }
    cell.accessoryType = indexPath.row == self.index ?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.index = indexPath.row;
    [self reloadData];
    if (self.didSelectMoneyTypeCellBlock) {
        self.didSelectMoneyTypeCellBlock(indexPath.row);
    }
}
@end
