//
//  YNLogisticalMsgTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNLogisticalMsgTableView.h"

@interface YNLogisticalMsgTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNLogisticalMsgTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_CLEAR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    _dataArray = [YNLogisticalCellFrame initWithFromDictionaries:dataArray];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNLogisticalCellFrame *cellFrame = _dataArray[indexPath.row];
    return cellFrame.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNLogisticalMsgCell * msgCell = [tableView dequeueReusableCellWithIdentifier:@"msgCell"];
    if (msgCell == nil) {
        msgCell = [[YNLogisticalMsgCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        msgCell.selectionStyle = UITableViewCellSelectionStyleNone;
        msgCell.backgroundColor = COLOR_CLEAR;
    }
    YNLogisticalCellFrame *cellFrame = _dataArray[indexPath.row];
    if (indexPath.row == 0) {
        cellFrame.cellType = FirstSatus;
    }else if (indexPath.row == _dataArray.count-1){
        cellFrame.cellType = CommonStatus;
    }else{
        cellFrame.cellType = LastStatus;
    }
    msgCell.cellFrame = cellFrame;
    return msgCell;
}
@end

@implementation YNLogisticalCellFrame

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    CGSize msgSize = [dict[@"msg"] calculateHightWithWidth:SCREEN_WIDTH-(kMaxSpace+kMidSpace+W_RATIO(2))-kMaxSpace font:FONT(32)];
    self.msgF = CGRectMake(kMaxSpace+kMidSpace+W_RATIO(2), kMidSpace, msgSize.width, msgSize.height);
    
    CGSize timeSize = [dict[@"time"] calculateHightWithWidth:WIDTH(_msgF) font:FONT(26)];
    self.timeF = CGRectMake(X(_msgF), MaxY(_msgF)+W_RATIO(20), timeSize.width, timeSize.height);
    
    self.cellHeight = MaxY(_timeF)+kMidSpace;
    self.markF = CGRectMake(kMaxSpace-(W_RATIO(40)-W_RATIO(2))/2.0, kMidSpace, W_RATIO(40), W_RATIO(40));
    
    self.pointF = CGRectMake(kMaxSpace-(W_RATIO(16)-W_RATIO(2))/2.0, kMidSpace, W_RATIO(16), W_RATIO(16));
    
    self.lineUpF = CGRectMake(kMaxSpace, 0, W_RATIO(2), Y(_pointF));
    self.lineDownF = CGRectMake(kMaxSpace, MaxY(_pointF), W_RATIO(2), _cellHeight-MaxY(_pointF));

}

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array{
    
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithArray:array];
    
    NSMutableArray *endArray = [NSMutableArray array];
    
    [tempArrayM enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        YNLogisticalCellFrame *cellFrame = [[YNLogisticalCellFrame alloc] init];
        cellFrame.dict = dict;
        [endArray addObject:cellFrame];
    }];
    
    return endArray;
}

@end
@interface YNLogisticalMsgCell ()

@property (nonatomic,weak) UIImageView * markImgView;

@property (nonatomic,weak) UIView * pointView;

@property (nonatomic,weak) UIView * lineUpView;

@property (nonatomic,weak) UIView * lineDownView;

@property (nonatomic,weak) UILabel * msgLabel;

@property (nonatomic,weak) UILabel * timeLabel;

@end
@implementation YNLogisticalMsgCell

-(void)setCellFrame:(YNLogisticalCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    
    [self setupCellFrame:cellFrame];
    
    [self setupCellContent:cellFrame];
    
}


-(void)setupCellFrame:(YNLogisticalCellFrame*)cellFrame{
    self.msgLabel.frame = cellFrame.msgF;
    self.timeLabel.frame = cellFrame.timeF;
    self.pointView.frame = cellFrame.pointF;
    self.pointView.layer.cornerRadius = WIDTHF(_pointView)/2.0;
    
    self.lineDownView.frame = cellFrame.lineDownF;
    self.lineUpView.frame = cellFrame.lineUpF;
    self.markImgView.frame = cellFrame.markF;
}
-(void)setupCellContent:(YNLogisticalCellFrame*)cellFrame{
    self.msgLabel.text = cellFrame.dict[@"msg"];
    self.timeLabel.text = cellFrame.dict[@"time"];
    
    if (cellFrame.cellType == FirstSatus) {
        self.msgLabel.textColor = COLOR_DF463E;
        self.timeLabel.textColor = COLOR_DF463E;
        self.markImgView.hidden = NO;
        self.pointView.hidden = YES;
        self.lineUpView.hidden = YES;
        self.lineDownView.hidden = NO;
    }else if (cellFrame.cellType == LastStatus){
        self.markImgView.hidden = YES;
        self.pointView.hidden = NO;
        self.lineUpView.hidden = NO;
        self.lineDownView.hidden = NO;
    }else if (cellFrame.cellType == CommonStatus){
        self.markImgView.hidden = YES;
        self.pointView.hidden = NO;
        self.lineUpView.hidden = NO;
        self.lineDownView.hidden = YES;
    }
    
}
-(UIImageView *)markImgView{
    if (!_markImgView) {
        UIImageView *markImgView = [[UIImageView alloc] init];
        _markImgView = markImgView;
        [self.contentView addSubview:markImgView];
        markImgView.image = [UIImage imageNamed:@"gou_hong_gouwuche"];
    }
    return _markImgView;
}
-(UIView *)pointView{
    if (!_pointView) {
        UIView *pointView = [[UIView alloc] init];
        _pointView = pointView;
        [self.contentView addSubview:pointView];
        pointView.layer.masksToBounds = YES;
        pointView.backgroundColor = COLOR_BABABA;
    }
    return _pointView;
}
-(UIView *)lineUpView{
    if (!_lineUpView) {
        UIView *lineUpView = [[UIView alloc] init];
        _lineUpView = lineUpView;
        [self.contentView addSubview:lineUpView];
        lineUpView.backgroundColor = COLOR_BABABA;
    }
    return _lineUpView;
}
-(UIView *)lineDownView{
    if (!_lineDownView) {
        UIView *lineDownView = [[UIView alloc] init];
        _lineDownView = lineDownView;
        [self.contentView addSubview:lineDownView];
        lineDownView.backgroundColor = COLOR_BABABA;
    }
    return _lineDownView;
}
-(UILabel *)msgLabel{
    if (!_msgLabel) {
        UILabel *msgLabel = [[UILabel alloc] init];
        _msgLabel = msgLabel;
        [self.contentView addSubview:msgLabel];
        msgLabel.font = FONT(32);
        msgLabel.numberOfLines = 0;
        msgLabel.textColor = COLOR_999999;
    }
    return _msgLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        _timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        timeLabel.font = FONT(26);
        timeLabel.numberOfLines = 0;
        timeLabel.textColor = COLOR_999999;
    }
    return _timeLabel;
}
@end
