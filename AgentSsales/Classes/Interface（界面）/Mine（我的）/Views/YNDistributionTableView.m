//
//  YNDistributionTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNDistributionTableView.h"

@interface YNDistributionTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNDistributionTableView

-(instancetype)init{
    CGRect frame = CGRectMake(0,W_RATIO(560), SCREEN_WIDTH, SCREEN_HEIGHT-W_RATIO(560));
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.rowHeight = W_RATIO(100);
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_FFFFFF;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W_RATIO(84));
        headerView.backgroundColor = COLOR_FFFFFF;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, HEIGHTF(headerView)-W_RATIO(2), WIDTHF(headerView), W_RATIO(2));
        lineView.backgroundColor = COLOR_EDEDED;
        [headerView addSubview:lineView];
        
        NSArray<NSString*> *itemTitles = @[LocalTime,LocalSource,LocalCommission];
        CGFloat itemWidth = (SCREEN_WIDTH-kMidSpace*2-kMinSpace*(itemTitles.count-1))/itemTitles.count;
        [itemTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel * itemlabel = [[UILabel alloc] init];
            [headerView addSubview:itemlabel];
            itemlabel.text = title;
            itemlabel.font = FONT(26);
            itemlabel.textColor = COLOR_999999;
            itemlabel.textAlignment = NSTextAlignmentCenter;
            itemlabel.frame = CGRectMake(kMidSpace+idx*(itemWidth+kMinSpace), 0, itemWidth, HEIGHTF(headerView)-HEIGHTF(lineView));
        }];
        
        UIView *footerView = [[UIView alloc] init];
        footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kMinSpace);
        
        self.tableHeaderView = headerView;
        self.tableFooterView = footerView;
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YNDistributionCell * distributeCell = [tableView dequeueReusableCellWithIdentifier:@"distributeCell"];
    if (distributeCell == nil) {
        distributeCell = [[YNDistributionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mineCell"];
        distributeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, HEIGHTF(distributeCell.contentView)-W_RATIO(2), WIDTHF(distributeCell.contentView), W_RATIO(2));
        lineView.backgroundColor = COLOR_EDEDED;
        [distributeCell.contentView addSubview:lineView];
    }
    distributeCell.dict = _dataArrayM[indexPath.row];
    return distributeCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end

@interface YNDistributionCell ()
/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic,weak) UILabel *resouceLabel;
/** 佣金 */
@property (nonatomic,weak) UILabel *moneyLabel;

@end

@implementation YNDistributionCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.timeLabel.text = dict[@"createtime"];
    self.resouceLabel.text = dict[@"nickname"];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@%@",LocalMoneyMark,dict[@"money"]];
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        _timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        timeLabel.font = FONT(30);
        timeLabel.textColor = COLOR_333333;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.frame = CGRectMake(kMidSpace, 0, (SCREEN_WIDTH-kMidSpace*2-kMinSpace*2)/3.0, HEIGHTF(self.contentView));
    }
    return _timeLabel;
}
-(UILabel *)resouceLabel{
    if (!_resouceLabel) {
        UILabel *resouceLabel = [[UILabel alloc] init];
        _resouceLabel = resouceLabel;
        [self.contentView addSubview:resouceLabel];
        resouceLabel.font = FONT(30);
        resouceLabel.textColor = COLOR_333333;
        resouceLabel.textAlignment = NSTextAlignmentCenter;
        resouceLabel.frame = CGRectMake(MaxXF(_timeLabel)+kMinSpace, YF(_timeLabel), WIDTHF(_timeLabel), HEIGHTF(_timeLabel));
    }
    return _resouceLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        UILabel *moneyLabel = [[UILabel alloc] init];
        _moneyLabel = moneyLabel;
        [self.contentView addSubview:moneyLabel];
        moneyLabel.font = FONT(30);
        moneyLabel.textColor = COLOR_DF463E;
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.frame = CGRectMake(MaxXF(_resouceLabel)+kMinSpace, YF(_resouceLabel), WIDTHF(_resouceLabel), HEIGHTF(_resouceLabel));
    }
    return _moneyLabel;
}

@end



