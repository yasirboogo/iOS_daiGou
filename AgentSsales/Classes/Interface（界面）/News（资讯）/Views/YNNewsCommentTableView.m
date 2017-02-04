//
//  YNNewsCommentTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/23.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsCommentTableView.h"

@interface YNNewsCommentTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNNewsCommentTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;

        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = COLOR_EDEDED;
        footerView.frame = CGRectMake(0, 0, WIDTHF(self), kMinSpace);
        self.tableFooterView = footerView;
        
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    _dataArray = [YNNewsCommentCellFrame initWithFromDictionaries:dataArray];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNNewsCommentCellFrame *cellFrame = _dataArray[indexPath.row];
    return cellFrame.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNNewsCommentCell * commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    if (commentCell == nil) {
        commentCell = [[YNNewsCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"commentCell"];
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = COLOR_EDEDED;
        lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W_RATIO(2));
        [commentCell.contentView addSubview:lineView];
    }
    commentCell.cellFrame = _dataArray[indexPath.row];
    return commentCell;
}

@end
@implementation YNNewsCommentCellFrame

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.icoF = CGRectMake(W_RATIO(30), W_RATIO(20), W_RATIO(64), W_RATIO(64));
    
    CGSize timeSize = [dict[@"time"] calculateHightWithFont:FONT(22) maxWidth:SCREEN_WIDTH/3.0];
    self.timeF = CGRectMake(SCREEN_WIDTH-timeSize.width-kMidSpace, Y(_icoF), timeSize.width, timeSize.height);
    self.nameF = CGRectMake(MaxX(_icoF)+W_RATIO(30), Y(_icoF),X(_timeF)-MaxX(_icoF)-W_RATIO(30)*2 , HEIGHT(_icoF)/2.0);
    
    CGSize contentSize = [dict[@"content"] calculateHightWithWidth:MaxX(_timeF)-X(_nameF) font:FONT(30)];
    self.contentF = CGRectMake(X(_nameF), MaxY(_icoF), contentSize.width, contentSize.height);
    
    self.cellHeight = MaxY(_contentF)+kMidSpace;
}
+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array{
    
    NSArray *tempArray = [NSArray arrayWithArray:array];
    
    NSMutableArray *endArray = [NSMutableArray array];
    
    [tempArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        YNNewsCommentCellFrame *cellFrame = [[YNNewsCommentCellFrame alloc] init];
        cellFrame.dict = dict;
        [endArray addObject:cellFrame];
    }];
    
    return endArray;
}
@end
@interface YNNewsCommentCell ()

@property (nonatomic,weak) UIImageView * icoImgView;

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UILabel * timeLabel;

@property (nonatomic,weak) UILabel * contentLabel;

@end
@implementation YNNewsCommentCell
-(void)setCellFrame:(YNNewsCommentCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    
    [self setupCellFrame:cellFrame];
    
    [self setupCellContent:cellFrame];
    
}

-(void)setupCellFrame:(YNNewsCommentCellFrame*)cellFrame{

    self.icoImgView.frame = cellFrame.icoF;
    self.icoImgView.layer.cornerRadius = WIDTHF(_icoImgView)/2.0;
    self.timeLabel.frame = cellFrame.timeF;
    self.nameLabel.frame = cellFrame.nameF;
    self.contentLabel.frame = cellFrame.contentF;
}
-(void)setupCellContent:(YNNewsCommentCellFrame*)cellFrame{
    
    self.icoImgView.image = [UIImage imageNamed:cellFrame.dict[@"ico"]];
    self.timeLabel.text = cellFrame.dict[@"time"];
    self.nameLabel.text = cellFrame.dict[@"name"];
    self.contentLabel.text = cellFrame.dict[@"content"];
}

-(UIImageView *)icoImgView{
    if (!_icoImgView) {
        UIImageView *icoImgView = [[UIImageView alloc] init];
        _icoImgView = icoImgView;
        [self.contentView addSubview:icoImgView];
        icoImgView.layer.masksToBounds = YES;
    }
    return _icoImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.contentView addSubview:nameLabel];
        nameLabel.font = FONT(30);
        nameLabel.textColor = COLOR_328FFF;
    }
    return _nameLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        _timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        timeLabel.font = FONT(22);
        timeLabel.textColor = COLOR_999999;
    }
    return _timeLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        [self.contentView addSubview:contentLabel];
        contentLabel.numberOfLines = 0;
        contentLabel.font = FONT(30);
        contentLabel.textColor = COLOR_333333;
    }
    return _contentLabel;
}
@end;
