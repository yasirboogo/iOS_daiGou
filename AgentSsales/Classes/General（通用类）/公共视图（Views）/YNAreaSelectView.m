//
//  YNAreaSelectView.m
//  AgentSsales1
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNAreaSelectView.h"

@interface YNAreaSelectView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *cityArray;

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger countryIndex;

@property (nonatomic, assign) NSInteger provinceIndex;

@property (nonatomic, assign) NSInteger cityIndex;

@property (nonatomic, assign) NSInteger districtIndex;

@end

@implementation YNAreaSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self collectionView];

        self.backgroundColor = COLOR_CLEAR;
    }
    return self;
}
#pragma mark - 加载数据
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 2*kMidSpace;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kMidSpace, 0, kMidSpace);
        UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        [self addSubview:collectionView];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.backgroundColor = COLOR_CLEAR;
        
        collectionView.showsHorizontalScrollIndicator = NO;
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[YNAreaSelectCell class] forCellWithReuseIdentifier:@"areaCell"];
    }
    return _collectionView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return CGSizeMake(SCREEN_WIDTH-2*kMidSpace, W_RATIO(90)*2+W_RATIO(90));
    }
    return CGSizeMake(SCREEN_WIDTH-2*kMidSpace,HEIGHTF(self));
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
-(NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChinaAreaCN.plist" ofType:nil]][@"address"];
        
        //_cityArray = [YNChinaProvinceModel arrayOfModelsFromDictionaries:result[@"address"] error:nil];
    }
    return _cityArray;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNAreaSelectCell *areaCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"areaCell" forIndexPath:indexPath];
    areaCell.headerFrame = CGRectMake(0, 0, SCREEN_WIDTH-2*kMidSpace, W_RATIO(90));
    areaCell.tableFrame = CGRectMake(0, MaxY(areaCell.headerFrame), SCREEN_WIDTH-2*kMidSpace, HEIGHTF(self)-HEIGHT(areaCell.headerFrame));
    if (indexPath.row == 0) {
        areaCell.tableFrame = CGRectMake(0,MaxY(areaCell.headerFrame), SCREEN_WIDTH-2*kMidSpace, W_RATIO(90)*2);
    }
    [areaCell setDidSelectAreaSelectCellBlock:^(NSInteger index) {
        if (indexPath.row < 3) {
            self.collectionView.contentOffset = CGPointMake((indexPath.row+1)*SCREEN_WIDTH, 0);
            if (indexPath.row == 0) {
                self.countryIndex = index;
            }else if (indexPath.row == 1){
                self.provinceIndex = index;
            }else if (indexPath.row == 2){
                self.cityIndex = index;
            }
            [self.collectionView reloadData];
        }else if (indexPath.row == 3){
            self.districtIndex = index;
            if (self.didSelectAreaSelectResultBlock) {
                NSString *country = [NSString string];
                NSString *province = [NSString string];
                NSString *city = [NSString string];
                NSString *district = [NSString string];
                if (_countryIndex == 0) {
                    country = @"中国";
                    province = self.cityArray[_provinceIndex][@"name"];
                    city = self.cityArray[_provinceIndex][@"sub"][_cityIndex][@"name"];
                    district = self.cityArray[_provinceIndex][@"sub"][_cityIndex][@"sub"][_districtIndex];
                }else if (_countryIndex == 1){
                    country = @"马来西亚";
                }
                NSString *area = [NSString stringWithFormat:@"%@%@%@%@",country,province,city,district];
                self.didSelectAreaSelectResultBlock(area);
            }
            [self dismissPopView:YES];
        }
    }];
    NSArray *titles = @[@"选择国家",@"选择省份",@"选择城市",@"选择地区"];
    areaCell.title = titles[indexPath.row];
    if (indexPath.row == 0) {
        areaCell.dataArray = @[@"中国",@"马来西亚"];
    }else if (indexPath.row == 1){
        if (self.countryIndex == 0) {
            areaCell.dataArray = self.cityArray;
        }
    }else if (indexPath.row == 2){
        areaCell.dataArray = self.cityArray[_provinceIndex][@"sub"];
    }else if (indexPath.row == 3){
        areaCell.dataArray = self.cityArray[_provinceIndex][@"sub"][_cityIndex][@"sub"];
    }
    return areaCell;
}
- (void)showPopView:(BOOL)animated
{
    [self.baseView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.baseView];
    
    if (!animated) {
        return;
    }
    
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.alpha = 0.f;
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}
- (void)dismissPopView:(BOOL)animated
{
    if (!animated) {
        [self.baseView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.baseView removeFromSuperview];
    }];
}
-(UIView *)baseView{
    if (!_baseView) {
        UIView *baseView = [[UIView alloc] init];
        _baseView = baseView;
        [baseView setFrame:[UIScreen mainScreen].bounds];
        [baseView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [baseView setUserInteractionEnabled:YES];
        
    }
    return _baseView;
}
-(void)setIsTapGesture:(BOOL)isTapGesture{
    _isTapGesture = isTapGesture;
    if (isTapGesture) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureClick:)];
        [self.baseView addGestureRecognizer:tapGesture];
    }
}

- (void)handleTapGestureClick:(UITapGestureRecognizer *)tap
{
    [self dismissPopView:YES];
}

@end



@interface YNAreaSelectCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,weak) UILabel * titleLabel;
@end
@implementation YNAreaSelectCell

-(void)setTableFrame:(CGRect)tableFrame{
    _tableFrame = tableFrame;
    self.tableView.frame = tableFrame;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
-(void)setHeaderFrame:(CGRect)headerFrame{
    _headerFrame = headerFrame;
    self.titleLabel.frame = headerFrame;
    [self.tableView reloadData];
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    [self.tableView reloadData];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        titleLabel.backgroundColor = COLOR_FFFFFF;
        titleLabel.font = FONT(36);
        titleLabel.textColor = COLOR_DF463E;
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        [self.contentView addSubview:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = W_RATIO(90);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = COLOR_FFFFFF;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] init];
        [cell.contentView addSubview:lineView];
        lineView.backgroundColor = COLOR_EDEDED;
        lineView.frame = CGRectMake(0, 0, WIDTHF(cell.contentView), W_RATIO(2));
    }
    if ([_dataArray.firstObject isKindOfClass:[NSDictionary class]]) {
        cell.textLabel.text  = _dataArray[indexPath.row][@"name"];
    }else if ([_dataArray.firstObject isKindOfClass:[NSString class]]){
        cell.textLabel.text  = _dataArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.didSelectAreaSelectCellBlock) {
        self.didSelectAreaSelectCellBlock(indexPath.row);
    }
}
@end
