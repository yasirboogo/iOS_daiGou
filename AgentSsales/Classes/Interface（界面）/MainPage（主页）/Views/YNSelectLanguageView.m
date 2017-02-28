//
//  YNSelectLanguageView.m
//  AgentSsales1
//
//  Created by innofive on 17/2/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSelectLanguageView.h"

@interface YNSelectLanguageView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNSelectLanguageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0x1A1717 andAlpha:0.9];
        self.rowHeight = W_RATIO(90);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        self.index = [LanguageManager  currentLanguageIndex];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = COLOR_CLEAR;
        
        cell.textLabel.font = FONT(30);
        cell.textLabel.textColor = COLOR_FFFFFF;
        cell.tintColor = COLOR_FFFFFF;
    }
    cell.accessoryType = indexPath.row == self.index ?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.index = indexPath.row;
    [self reloadData];
    if (self.didSelectLanguageCellBlock) {
        self.didSelectLanguageCellBlock(indexPath.row);
    }
}
@end
