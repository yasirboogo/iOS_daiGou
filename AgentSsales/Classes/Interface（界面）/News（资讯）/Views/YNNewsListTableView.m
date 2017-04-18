//
//  YNNewsListTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsListTableView.h"

@interface YNNewsListTableView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation YNNewsListTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _adArrayM.count+_dataArrayM.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return W_RATIO(318);
    }
    return kZero;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kZero;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.row+1)%4 == 0 || indexPath.row == _adArrayM.count+_dataArrayM.count-1) {
        return W_RATIO(150);
    }
    return W_RATIO(220);
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIImageView *headImgView = [[UIImageView alloc] init];
        [headImgView sd_setImageWithURL:[NSURL URLWithString:_imgInfor[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei2"]];
        return headImgView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.row+1)%4 == 0 || indexPath.row == _adArrayM.count+_dataArrayM.count-1) {
        YNNewsAdCell * adCell = [tableView dequeueReusableCellWithIdentifier:@"adCell"];
        if (adCell == nil) {
            adCell = [[YNNewsAdCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"adCell"];
            adCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if ((indexPath.row+1)%4 == 0) {
            adCell.imageUrl = _adArrayM[(indexPath.row+1)/4-1][@"img"];
        }else{
            adCell.imageUrl = [_adArrayM lastObject][@"img"];
        }
        return adCell;
    }else{
        YNNewsListCell * listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
        if (listCell == nil) {
            listCell = [[YNNewsListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"listCell"];
            listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        listCell.dict = _dataArrayM[indexPath.row-((indexPath.row+1)/4)];
        return listCell;
    }
}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ((indexPath.row+1)%4 == 0 || indexPath.row == _adArrayM.count+_dataArrayM.count-1) {
        if (self.didSelectAdCellBlock) {
            if ((indexPath.row+1)%4 == 0) {
                self.didSelectAdCellBlock([NSString stringWithFormat:@"%@",_adArrayM[(indexPath.row+1)/4-1][@"type"]],_adArrayM[(indexPath.row+1)/4-1][@"url"]);
            }else{
                self.didSelectAdCellBlock([NSString stringWithFormat:@"%@",[_adArrayM lastObject][@"type"]],[_adArrayM lastObject][@"url"]);
            }
        }
    }else{
        if (self.didSelectNewsListCellBlock) {
            self.didSelectNewsListCellBlock([NSString stringWithFormat:@"%@",_dataArrayM[indexPath.row-((indexPath.row+1)/4)][@"messageId"]]);
        }
    }
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
/*
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    return [super setFrame:frame];
}
 */
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

    [self.rightImgView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei2"]];
    self.nameLabel.text = dict[@"title"];
    self.timeLabel.text = dict[@"createtime"];
    self.commentLabel.text = [NSString stringWithFormat:@"%@",dict[@"review"]];
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
        rightImgView.frame = CGRectMake(WIDTH(self.contentView)-W_RATIO(14)-W_RATIO(278), W_RATIO(14), W_RATIO(278), W_RATIO(192));
    }
    return _rightImgView;
}
@end
@interface YNNewsAdCell ()

@property (nonatomic,weak) UIImageView * adImgView;

@end
@implementation YNNewsAdCell

-(void)setImageUrl:(NSString *)imageUrl{
    [self.adImgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"zhanwei2"]];
}
-(UIImageView *)adImgView{
    if (!_adImgView) {
        UIImageView *adImgView = [[UIImageView alloc] init];
        _adImgView = adImgView;
        [self.contentView addSubview:adImgView];
        adImgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W_RATIO(150));
    }
    return _adImgView;
}
@end
