//
//  YNSelectAreaTableView.m
//  AgentSsales
//
//  Created by innofive on 17/4/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSelectAreaTableView.h"

@interface YNSelectAreaTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    SelectAreaType _areaType;
    NSArray* _cityArray;
}
@property (nonatomic,copy) NSMutableString * selectAddress;

@property (nonatomic,copy) NSString * countryid;

@property (nonatomic,copy) NSString * shenid;

@property (nonatomic,copy) NSString * shiid;

@property (nonatomic,copy) NSString * quid;
@end

@implementation YNSelectAreaTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.rowHeight = W_RATIO(120);
        self.dataSource = self;
        self.delegate = self;
        _areaType = AreaCountry;
        [self setSeparatorColor:COLOR_EDEDED];
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    _cityArray = dataArray;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = FONT(32);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头 
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    NSArray *tempArray = [NSArray array];
    if (_areaType == AreaCountry) {
        cell.textLabel.text = _cityArray[indexPath.row][@"countryname"];
        tempArray = _cityArray[indexPath.row][@"countryArray"];
    }else if (_areaType == AreaProvinces){
        cell.textLabel.text = _cityArray[indexPath.row][@"shenname"];
        tempArray = _cityArray[indexPath.row][@"shiArray"];
    }else if (_areaType == AreaCity){
        cell.textLabel.text = _cityArray[indexPath.row][@"shiname"];
        tempArray = _cityArray[indexPath.row][@"quArray"];
    }else if (_areaType == AreaDistrict){
        cell.textLabel.text = _cityArray[indexPath.row][@"quname"];
    }
    if (!tempArray.count) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_areaType == AreaCountry) {
        NSArray *tempArray = _cityArray[indexPath.row][@"countryArray"];
        _selectAddress = [NSMutableString stringWithFormat:@"%@",_cityArray[indexPath.row][@"countryname"]];
        self.countryid = [NSString stringWithFormat:@"%@",_cityArray[indexPath.row][@"countryid"]];
        if (tempArray.count) {
            _cityArray = tempArray;
            _areaType = AreaProvinces;
        }else{
            if (self.didSelectAddressName) {
                self.didSelectAddressName(_selectAddress,_countryid,@"0",@"0",@"0");
            }
        }
    }else if (_areaType == AreaProvinces){
        NSArray *tempArray = _cityArray[indexPath.row][@"shiArray"];
        [_selectAddress appendString:_cityArray[indexPath.row][@"shenname"]];
        self.shenid = [NSString stringWithFormat:@"%@",_cityArray[indexPath.row][@"shenid"]];
        if (tempArray.count) {
            _cityArray = tempArray;
            _areaType = AreaCity;
        }else{
            if (self.didSelectAddressName) {
                self.didSelectAddressName(_selectAddress,_countryid,_shenid,@"0",@"0");
            }
        }
    }else if (_areaType == AreaCity){
        NSArray *tempArray = _cityArray[indexPath.row][@"quArray"];
        [_selectAddress appendString:_cityArray[indexPath.row][@"shiname"]];
        self.shiid = [NSString stringWithFormat:@"%@",_cityArray[indexPath.row][@"shiid"]];
        if (tempArray.count) {
            _cityArray = tempArray;
            _areaType = AreaDistrict;
        }else{
            if (self.didSelectAddressName) {
                self.didSelectAddressName(_selectAddress,_countryid,_shenid,_shiid,@"0");
            }
        }
    }else if (_areaType == AreaDistrict){
        [_selectAddress appendString:_cityArray[indexPath.row][@"quname"]];
        self.quid = [NSString stringWithFormat:@"%@",_cityArray[indexPath.row][@"quid"]];
        if (self.didSelectAddressName) {
            self.didSelectAddressName(_selectAddress,_countryid,_shenid,_shiid,_quid);
        }
    }
    [self reloadData];
}
@end
