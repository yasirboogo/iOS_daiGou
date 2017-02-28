//
//  YSearchHistoryView.m
//  AgentSsales
//
//  Created by innofive on 17/2/7.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YSearchHistoryView.h"

#define USERID 1

#define kHistoryCount 6

@interface YSearchHistoryView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UIButton * delectBtn;

@property (nonatomic,weak) UICollectionView * collectionView;

@property (nonatomic,strong) NSArray * historyArray;

@end

@implementation YSearchHistoryView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.delectBtn setImage:[UIImage imageNamed:@"shanchujilui_fanhu"] forState:UIControlStateNormal];
        
        self.nameLabel.text = @"搜索历史";
        
        self.collectionView.backgroundColor = COLOR_EDEDED;
        NSString *path = NSHomeDirectory();//主目录
        NSLog(@"NSHomeDirectory:%@",path);
    }
    return self;
}

-(void)setSearchContent:(NSString *)searchContent{
    _searchContent = searchContent;
    
    [self saveUpdateHistoryRecord];
}

-(UIButton *)delectBtn{
    if (!_delectBtn) {
        UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delectBtn = delectBtn;
        [self addSubview:delectBtn];
        [delectBtn addTarget:self action:@selector(handleDelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        delectBtn.frame = CGRectMake(SCREEN_WIDTH-kMidSpace-kMidSpace, kMidSpace+(W_RATIO(80)-kMidSpace)/2.0, kMidSpace, kMidSpace);
    }
    return _delectBtn;
}
-(void)handleDelectButtonClick:(UIButton*)btn{
    [self delectUpdateHistoryRecord];
    [self.collectionView reloadData];
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self addSubview:nameLabel];
        nameLabel.font = FONT(24);
        nameLabel.textColor = COLOR_999999;
        nameLabel.frame = CGRectMake(W_RATIO(30),YF(self.delectBtn), MaxXF(self.delectBtn)-W_RATIO(30)*2, HEIGHTF(self.delectBtn));
    }
    return _nameLabel;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        CGRect frame = CGRectMake(W_RATIO(30), MaxYF(self.nameLabel)+W_RATIO(20), SCREEN_WIDTH-W_RATIO(30)*2, SCREEN_HEIGHT-MaxYF(self.nameLabel)-W_RATIO(20)*2);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(W_RATIO(222), W_RATIO(58));
        flowLayout.minimumLineSpacing = W_RATIO(12);
        flowLayout.minimumInteritemSpacing = W_RATIO(10);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        [self addSubview:collectionView];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[YNSearchHistoryCell class] forCellWithReuseIdentifier:@"historyCell"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.historyArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNSearchHistoryCell *historyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"historyCell" forIndexPath:indexPath];
    historyCell.backgroundColor = COLOR_FFFFFF;
    YNHistoryModel *historyModel = self.historyArray[indexPath.row];
    historyCell.searchContent = historyModel.searchContent;
    return historyCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    YNHistoryModel *historyModel = self.historyArray[indexPath.row];
    if (self.didSelectSearchHistoryCellBlock) {
        self.didSelectSearchHistoryCellBlock(historyModel.searchContent);
    }
}
-(void)saveUpdateHistoryRecord{
    NSArray *historyArray = [YNHistoryModel findWithFormat:@"Where userId = %d",USERID];
    
    if (self.historyArray.count > 0 && self.historyArray.count <= kHistoryCount ){
        YNHistoryModel *model = self.historyArray[self.historyArray.count-1];
        if (![model.searchContent isEqualToString:self.searchContent]) {//相邻不重复
            if (self.historyArray.count == kHistoryCount){
                [YNHistoryModel deleteObjectsWithFormat:@"Where userId = %d AND sordId = %d",USERID,0];
                for (int i = 1; i < kHistoryCount; i ++) {
                    YNHistoryModel *model = historyArray[i];
                    model.sordId = [NSString stringWithFormat:@"%d",i-1];
                    [model update];
                }
            }
            YNHistoryModel *history = [[YNHistoryModel alloc] init];
            history.userId = [NSString stringWithFormat:@"%d",USERID];
            history.searchContent = self.searchContent;
            if (historyArray.count == kHistoryCount) {
                history.sordId = [NSString stringWithFormat:@"%lu", historyArray.count-1];
            }else{
                history.sordId = [NSString stringWithFormat:@"%ld",(unsigned long)historyArray.count];
            }
            [history save];
        }
    }
    else if (self.historyArray.count ==0){
        YNHistoryModel *history = [[YNHistoryModel alloc] init];
        history.userId = [NSString stringWithFormat:@"%d",USERID];
        history.searchContent = self.searchContent;
        history.sordId = [NSString stringWithFormat:@"%ld",(unsigned long)historyArray.count];
        [history save];
    }
    [self.collectionView reloadData];
}
-(void)delectUpdateHistoryRecord{
    [YNHistoryModel deleteObjectsWithFormat:@"Where userId = %d",USERID];
}
-(NSArray *)historyArray{
    
     _historyArray = [YNHistoryModel findWithFormat:@"Where userId = %d",USERID];
    return _historyArray;
}
@end
@interface YNSearchHistoryCell ()

@property (nonatomic,weak) UILabel * contentLabel;

@end
@implementation YNSearchHistoryCell

-(void)setSearchContent:(NSString *)searchContent{
    _searchContent = searchContent;
    self.contentLabel.text = searchContent;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        [self.contentView addSubview:contentLabel];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font = FONT(28);
        contentLabel.textColor = COLOR_333333;
        contentLabel.frame = self.bounds;
    }
    return _contentLabel;
}
@end
@implementation YNHistoryModel

@end


