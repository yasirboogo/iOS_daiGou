//
//  YNSettingTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSettingTableView.h"
#import "YNClearCache.h"

@interface YNSettingTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray<NSArray*> * items;

@property (nonatomic,strong) NSString *cache;

@end

@implementation YNSettingTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.rowHeight = W_RATIO(100);
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_CLEAR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self reloadData];
    }
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return kMinSpace;
    }
    return kZero;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kZero;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items[section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNSettingCell * setCell = [tableView dequeueReusableCellWithIdentifier:@"setCell"];
    
    
    if (setCell == nil) {
        setCell = [[YNSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setCell"];
        setCell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = COLOR_EDEDED;
        lineView.frame = CGRectMake(0, 0, WIDTH(setCell.contentView), W_RATIO(2));
        [setCell.contentView addSubview:lineView];
    }
    setCell.itemLabel.text = _items[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        setCell.isOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"ISACCEPT"];;
        [setCell setDidSelectSwitchButtonClick:^(BOOL isOn) {
            NSLog(@"%d",isOn);
        }];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        setCell.detailLabel.text = self.cache;
    }
    
    return setCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *itemName = _items[indexPath.section][indexPath.row];
    if ([itemName isEqualToString:@"推送开关"]) {
    }else if ([itemName isEqualToString:@"清除缓存"]){
        [YNClearCache clearCacheFile];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }else if ([itemName isEqualToString:@"意见反馈"]){
        
    }else if ([itemName isEqualToString:@"常见问题"]){
        
    }
}
-(NSArray<NSArray *> *)items{
    if (!_items) {
        _items = @[
                   @[@"推送开关"],
                   @[@"清除缓存",@"意见反馈",@"常见问题"]
                   ];
    }
    return _items;
}

-(NSString *)cache{
    _cache = [NSString stringWithFormat:@"%0.2fM",[YNClearCache cacheSize]];
    return _cache;
}

@end

@interface YNSettingCell ()

@property (nonatomic,copy) UISwitch * switchBtn;

@property (nonatomic,assign) BOOL isHaveSwitch;

@end
@implementation YNSettingCell

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.isHaveSwitch) {
        self.switchBtn.frame = CGRectMake(WIDTH(self.contentView)-kMaxSpace-WIDTH(_switchBtn),(HEIGHTF(self.contentView)-HEIGHTF(_switchBtn))/2.0,0.0,0.0);
        self.itemLabel.frame = CGRectMake(kMaxSpace, 0, XF(_switchBtn)-kMaxSpace-kMinSpace, HEIGHTF(self.contentView));
    }else{
        CGSize detailSize = [self.detailLabel.text calculateHightWithFont:_detailLabel.font maxWidth:WIDTH(self.contentView)/3.0];
        self.detailLabel.frame = CGRectMake(WIDTH(self.contentView)-kMaxSpace-detailSize.width, 0, detailSize.width, HEIGHTF(self.contentView));
        self.itemLabel.frame = CGRectMake(kMaxSpace, 0, XF(_detailLabel)-kMaxSpace-kMinSpace, HEIGHTF(self.contentView));
    }
}
-(void)setIsOn:(BOOL)isOn{
    _isOn = isOn;
    self.switchBtn.on = isOn;
    self.isHaveSwitch = YES;
}

-(UILabel *)itemLabel{
    if (!_itemLabel) {
        UILabel *itemLabel = [[UILabel alloc] init];
        _itemLabel = itemLabel;
        [self.contentView addSubview:itemLabel];
        itemLabel.font = FONT(30);
        itemLabel.textColor = COLOR_333333;
    }
    return _itemLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *detailLabel = [[UILabel alloc] init];
        _detailLabel = detailLabel;
        [self.contentView addSubview:detailLabel];
        detailLabel.font = FONT(30);
        detailLabel.textColor = COLOR_666666;
    }
    return _detailLabel;
}
-(UISwitch *)switchBtn{
    if (!_switchBtn) {
        UISwitch *switchBtn = [[UISwitch alloc] init];
        _switchBtn = switchBtn;
        [self.contentView addSubview:switchBtn];
        [switchBtn addTarget:self action:@selector(switchButtonClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}
-(void)switchButtonClick:(UISwitch*)btn{
    [[NSUserDefaults standardUserDefaults] setBool:btn.on forKey:@"ISACCEPT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.didSelectSwitchButtonClick) {
        self.didSelectSwitchButtonClick(btn.on);
    }
}
@end



