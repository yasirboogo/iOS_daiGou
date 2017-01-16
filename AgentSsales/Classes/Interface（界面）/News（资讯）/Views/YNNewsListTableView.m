//
//  YNNewsListTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsListTableView.h"

@interface YNNewsListTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) YNNewsHeaderView * headerView;

@end

@implementation YNNewsListTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.rowHeight = W_RATIO(220);
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(YNNewsHeaderView *)headerView{
    if (!_headerView) {
        YNNewsHeaderView *headerView = [[YNNewsHeaderView alloc] init];
        _headerView = headerView;
        headerView.frame = CGRectMake(0, 0, WIDTHF(self), W_RATIO(318));
        self.tableHeaderView = headerView;
    }
    return _headerView;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    self.headerView.dict = dataArray[0];
    
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count-1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNNewsListCell * listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    if (listCell == nil) {
        listCell = [[YNNewsListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"listCell"];
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    listCell.dict = _dataArray[indexPath.row+1];
    return listCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.didSelectNewsListCellBlock) {
        self.didSelectNewsListCellBlock(_dataArray[indexPath.row+1][@"title"]);
    }
}
@end
@interface YNNewsHeaderView ()
/** 图片 */
@property (nonatomic,weak) UIImageView * bigImgView;
/** 标题 */
@property (nonatomic,weak) UILabel * nameLabel;
@end

@implementation YNNewsHeaderView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.bigImgView.image = [UIImage imageNamed:dict[@"bigImg"]];
    self.nameLabel.text = dict[@"name"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
        CGSize nameSize = [_nameLabel.text calculateHightWithWidth:MaxXF(_bigImgView)-kMidSpace*2 font:_nameLabel.font line:_nameLabel.numberOfLines];
    self.nameLabel.frame = CGRectMake(kMidSpace, HEIGHTF(_bigImgView)-nameSize.height-W_RATIO(20), nameSize.width, nameSize.height);
}
-(UIImageView *)bigImgView{
    if (!_bigImgView) {
        UIImageView *bigImgView = [[UIImageView alloc] init];
        _bigImgView = bigImgView;
        [self addSubview:bigImgView];
        bigImgView.frame = self.bounds;
    }
    return _bigImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.bigImgView addSubview:nameLabel];
        nameLabel.font = FONT(36);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.numberOfLines = 2;
        nameLabel.textColor = COLOR_FFFFFF;
        nameLabel.shadowColor = COLOR_000000;
        nameLabel.shadowOffset = CGSizeMake(W_RATIO(3), W_RATIO(0));
    }
    return _nameLabel;
}
@end
@interface YNNewsListCell ()

/** 标题 */
@property (nonatomic,weak) UILabel * nameLabel;
/** 时间 */
@property (nonatomic,weak) UILabel * timeLabel;
/** 评论数 */
@property (nonatomic,weak) UILabel * commentLabel;
/** 评论图片 */
@property (nonatomic,weak) UIImageView * commentImgView;
/** 右边图片 */
@property (nonatomic,weak) UIImageView * rightImgView;

@end
@implementation YNNewsListCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

    self.rightImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.nameLabel.text = dict[@"name"];
    self.timeLabel.text = dict[@"time"];
    self.commentLabel.text = dict[@"comment"];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize nameSize = [_nameLabel.text calculateHightWithWidth:XF(_rightImgView)-kMidSpace*2 font:_nameLabel.font line:_nameLabel.numberOfLines];
    self.nameLabel.frame = CGRectMake(kMidSpace, YF(_rightImgView)*2, nameSize.width, nameSize.height);
    CGSize timeSize = [_timeLabel.text calculateHightWithFont:_timeLabel.font maxWidth:WIDTHF(_nameLabel)/2.0];
    self.timeLabel.frame = CGRectMake(XF(_nameLabel), HEIGHTF(self.contentView)-YF(_nameLabel)-timeSize.height, WIDTHF(_nameLabel)/2.0, timeSize.height);
    self.commentImgView.frame = CGRectMake(MaxXF(_timeLabel), YF(_timeLabel), HEIGHTF(_timeLabel), HEIGHTF(_timeLabel));
    self.commentLabel.frame = CGRectMake(MaxXF(_commentImgView)+kMinSpace, YF(_commentImgView),MaxXF(_nameLabel)-(MaxXF(_commentImgView)+kMinSpace), HEIGHTF(_commentImgView));
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.contentView addSubview:nameLabel];
        nameLabel.font = FONT(34);
        nameLabel.numberOfLines = 3;
        nameLabel.textColor = COLOR_333333;
    }
    return _nameLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        _timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        timeLabel.font = FONT(24);
        timeLabel.textColor = COLOR_999999;
    }
    return _timeLabel;
}
-(UILabel *)commentLabel{
    if (!_commentLabel) {
        UILabel *commentLabel = [[UILabel alloc] init];
        _commentLabel = commentLabel;
        [self.contentView addSubview:commentLabel];
        commentLabel.font = FONT(24);
        commentLabel.textColor = COLOR_999999;
    }
    return _commentLabel;
}
-(UIImageView *)commentImgView{
    if (!_commentImgView) {
        UIImageView *commentImgView = [[UIImageView alloc] init];
        _commentImgView = commentImgView;
        [self.contentView addSubview:commentImgView];
        commentImgView.image = [UIImage imageNamed:@"pinglun_zixun"];
    }
    return _commentImgView;
}
-(UIImageView *)rightImgView{
    if (!_rightImgView) {
        UIImageView *rightImgView = [[UIImageView alloc] init];
        _rightImgView = rightImgView;
        [self.contentView addSubview:rightImgView];
        rightImgView.frame = CGRectMake(WIDTH(self.contentView)-W_RATIO(14)-W_RATIO(278), W_RATIO(14), W_RATIO(278), W_RATIO(206));
    }
    return _rightImgView;
}





@end
