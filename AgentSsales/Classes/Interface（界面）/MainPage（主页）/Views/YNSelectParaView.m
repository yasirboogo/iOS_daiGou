//
//  YNSelectParaView.m
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSelectParaView.h"


@interface YNSelectParaView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UICollectionView *collectionView ;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation YNSelectParaView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
- (void)showPopView:(BOOL)animated
{
    [self.baseView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.baseView];
    
    if (!animated) {
        return;
    }
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    self.alpha = 0.f;
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT-SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
    
}
- (void)dismissPopView:(BOOL)animated
{
    if (!animated) {
        [self.baseView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
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
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0,MaxYF(self.cancelBtn), WIDTHF(self), HEIGHTF(self)-HEIGHTF(self.submitBtn)-MaxYF(_cancelBtn));
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = W_RATIO(20);
        flowLayout.minimumInteritemSpacing = W_RATIO(20);
        flowLayout.sectionInset = UIEdgeInsetsMake(0,W_RATIO(45), 0,W_RATIO(45));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        [self addSubview:collectionView];
        collectionView.backgroundColor = COLOR_FFFFFF;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[YNSelectParaViewCell class] forCellWithReuseIdentifier:@"paraCell"];
        [collectionView registerClass:[YNSelectCountViewCell class] forCellWithReuseIdentifier:@"countCell"];
        [collectionView registerClass:[YNSelectParaHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    }
    return _collectionView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArray.count+1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == _dataArray.count) {
        return 1;
    }else{
        NSArray *childArray = _dataArray[section][@"childArray"];
        return childArray.count;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _dataArray.count) {
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(60));
    }else{
        NSString *parameter = _dataArray[indexPath.section][@"childArray"][indexPath.row][@"value"];
        CGSize paraSize = [parameter calculateHightWithFont:FONT(30) maxWidth:0];
        return CGSizeMake(W_RATIO(150)>=paraSize.width?W_RATIO(150):paraSize.width,W_RATIO(60));
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(60));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(40));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNSelectParaHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if (indexPath.section == _dataArray.count) {
            headerView.title = [NSString stringWithFormat:@"%@",@"选择数量"];
        }else{
            headerView.title = [NSString stringWithFormat:@"%@%@",@"选择",_dataArray[indexPath.section][@"name"]];
        }
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _dataArray.count) {
        YNSelectCountViewCell *countCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"countCell" forIndexPath:indexPath];
        countCell.count = self.count;
        [countCell setDidChangeCountBlock:^(NSString * count) {
            self.count = count;
        }];
        return countCell;
    }else{
        YNSelectParaViewCell *paraCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"paraCell" forIndexPath:indexPath];
        paraCell.isSelect = NO;
        if (self.selectArrayM[indexPath.section] == indexPath) {
            paraCell.isSelect = YES;
        }
        paraCell.parameter = _dataArray[indexPath.section][@"childArray"][indexPath.row][@"value"];
        return paraCell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (indexPath.section < _dataArray.count) {
        [_selectArrayM replaceObjectAtIndex:indexPath.section withObject:indexPath];
        [self.collectionView reloadData];
    }
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        [self addSubview:submitBtn];
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [self.submitBtn setTitle:@"完成" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.frame = CGRectMake(0,HEIGHTF(self)-W_RATIO(100), WIDTHF(self), W_RATIO(100));
    }
    return _submitBtn;
}
-(void)handleSubmitButtonClick:(UIButton*)btn{
    [self dismissPopView:YES];
    if(self.didSelectSubmitButtonBlock){
        NSMutableString *style = [NSMutableString string];
        [_selectArrayM enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * childId = _dataArray[indexPath.section][@"childArray"][indexPath.row][@"childId"];
            [style appendFormat:@",%@",childId];
        }];
        if (style.length) {
            [style deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        self.didSelectSubmitButtonBlock(style,_count);
    }
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn = cancelBtn;
        [self addSubview:cancelBtn];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"guanbi_xuanguige"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(handleCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(WIDTHF(self)-W_RATIO(80),W_RATIO(80)-W_RATIO(50), W_RATIO(50), W_RATIO(50));
    }
    return _cancelBtn;
}
-(void)handleCancelButtonClick:(UIButton*)btn{
    [self dismissPopView:YES];
}
-(NSMutableArray<NSIndexPath *> *)selectArrayM{
    if (!_selectArrayM) {
        _selectArrayM = [NSMutableArray array];
        [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_selectArrayM addObject:[NSIndexPath indexPathForRow:0 inSection:idx]];
        }];
    }
    return _selectArrayM;
}
-(NSString *)count{
    if (!_count) {
        _count = @"1";
    }
    return _count;
}
@end

@interface YNSelectParaViewCell()

@property (nonatomic,weak) UILabel * selectLabel;

@end

@implementation YNSelectParaViewCell

-(void)setParameter:(NSString *)parameter{
    _parameter = parameter;
    CGSize paraSize = [parameter calculateHightWithFont:FONT(30) maxWidth:0];
    self.selectLabel.text = parameter;
    _selectLabel.frame = CGRectMake(0, 0, W_RATIO(150)>=paraSize.width?W_RATIO(150):paraSize.width,W_RATIO(60));
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (isSelect) {
        self.selectLabel.backgroundColor = COLOR_DF463E;
        self.selectLabel.textColor = COLOR_FFFFFF;
    }else{
        self.selectLabel.backgroundColor = COLOR_FFFFFF;
        self.selectLabel.textColor = COLOR_333333;
    }
}
-(UILabel *)selectLabel{
    if (!_selectLabel) {
        UILabel *selectLabel = [[UILabel alloc] init];
        _selectLabel = selectLabel;
        [self.contentView addSubview:selectLabel];
        selectLabel.layer.borderWidth = W_RATIO(1);
        selectLabel.textAlignment = NSTextAlignmentCenter;
        selectLabel.layer.borderColor = COLOR_CECECE.CGColor;
        selectLabel.font = FONT(30);
        selectLabel.textColor = COLOR_333333;
        selectLabel.backgroundColor = COLOR_FFFFFF;
    }
    return _selectLabel;
}
@end
@interface YNSelectCountViewCell()
@property (nonatomic,weak) UIButton * addBtn;
@property (nonatomic,weak) UIButton * subBtn;
@property (nonatomic,weak) UITextField * textField;
@end
@implementation YNSelectCountViewCell
-(void)setCount:(NSString *)count{
    _count = count;
    if ([count integerValue] >= 1) {
        _subBtn.enabled = [count integerValue] == 1?NO:YES;
        self.textField.text = count;
        if (self.didChangeCountBlock) {
            self.didChangeCountBlock(count);
        }
    }
}
-(UIButton *)subBtn{
    if (!_subBtn) {
        UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn = subBtn;
        [self.contentView addSubview:subBtn];
        subBtn.tag = 0;
        [subBtn setBackgroundImage:[UIImage imageNamed:@"jian_xuanguige"] forState:UIControlStateNormal];
        [subBtn addTarget:self action:@selector(handleCountChangeButton:) forControlEvents:UIControlEventTouchUpInside];
        subBtn.frame = CGRectMake(W_RATIO(45), 0, HEIGHTF(self.contentView),HEIGHTF(self.contentView));
    }
    return _subBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn = addBtn;
        [self.contentView addSubview:addBtn];
        addBtn.tag = 1;
        [addBtn setBackgroundImage:[UIImage imageNamed:@"jia_xuanguige"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(handleCountChangeButton:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.frame = CGRectMake(MaxXF(self.subBtn)+W_RATIO(20)*2+W_RATIO(210), YF(self.subBtn), WIDTHF(_subBtn),HEIGHTF(_subBtn));
    }
    return _addBtn;
}
-(void)handleCountChangeButton:(UIButton*)btn{
    if (btn.tag == 0) {
        self.count = [NSString stringWithFormat:@"%ld",[self.count integerValue]-1];
    }else if (btn.tag == 1){
        self.count = [NSString stringWithFormat:@"%ld",[self.count integerValue]+1];
    }
}
-(UITextField *)textField{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        _textField = textField;
        [self.contentView addSubview:textField];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = COLOR_333333;
        textField.layer.borderColor = COLOR_CECECE.CGColor;
        textField.layer.borderWidth = W_RATIO(1);
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.font = FONT(30);
        textField.frame = CGRectMake(MaxXF(self.subBtn)+W_RATIO(20), YF(_subBtn), XF(self.addBtn)-MaxXF(self.subBtn)-W_RATIO(20)*2, HEIGHTF(_subBtn));
    }
    return _textField;
}
@end
@interface YNSelectParaHeaderView()

@property (nonatomic,weak) UILabel * titleLabel;
@end

@implementation YNSelectParaHeaderView
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self addSubview:titleLabel];
        titleLabel.font = FONT(26);
        titleLabel.textColor = COLOR_999999;
        titleLabel.backgroundColor = COLOR_FFFFFF;
        titleLabel.frame = CGRectMake(W_RATIO(45),0,WIDTHF(self)-W_RATIO(45)*2, W_RATIO(60));
    }
    return _titleLabel;
}

@end


