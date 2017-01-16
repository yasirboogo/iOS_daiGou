//
//  YNUpdateInforTableView.m
//  AgentSsales
//
//  Created by innofive on 16/12/30.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNUpdateInforTableView.h"

@interface YNUpdateInforTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

@end

@implementation YNUpdateInforTableView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0,kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self reloadData];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.inforArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return W_RATIO(160);
    }
    return W_RATIO(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNUpdateInforCell * inforCell = [tableView dequeueReusableCellWithIdentifier:@"inforCell"];
    if (inforCell == nil) {
        inforCell = [[YNUpdateInforCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"inforCell"];
        inforCell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 0, WIDTHF(inforCell.contentView), kOutLine);
        lineView.backgroundColor = COLOR_EDEDED;
        [inforCell.contentView addSubview:lineView];
    }
    if (indexPath.row == 0) {
        inforCell.titleLabel.text = _inforArray[indexPath.row][@"title"];
        inforCell.headImgView.image = [UIImage imageNamed:_inforArray[indexPath.row][@"content"]];
    }else{
        if (indexPath.row == 2||indexPath.row == 4) {
            inforCell.isShowArrow = YES;
        }
        inforCell.titleLabel.text = _inforArray[indexPath.row][@"title"];
        inforCell.contentLabel.text = _inforArray[indexPath.row][@"content"];
    }
    return inforCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2||indexPath.row == 4) {
        if (self.didSelectUpdateInforClickBlock) {
            self.didSelectUpdateInforClickBlock(_inforArray[indexPath.row][@"title"]);
        }
    }
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[@{@"title":@"头像",@"content":@"testGoods"},
                        @{@"title":@"昵称",@"content":@"我是谁"},
                        @{@"title":@"手机号码",@"content":@"15571699700"},
                        @{@"title":@"身份证号码（选填）",@"content":@"420366199310101078"},
                        @{@"title":@"账户安全",@"content":@"密码修改"},
                        ];
    }
    return _inforArray;
}
@end

@implementation YNUpdateInforCell

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.titleLabel.frame = CGRectMake(kMidSpace, 0, titleSize.width, HEIGHTF(self.contentView));
    self.arrowImgView.frame = CGRectMake(SCREEN_WIDTH-(W_RATIO(50)+W_RATIO(12))/2.0,(HEIGHTF(self.contentView)-W_RATIO(22))/2.0, W_RATIO(12), W_RATIO(22));
    
    if (self.contentLabel.text.length) {
        self.contentLabel.frame = CGRectMake(MaxXF(_titleLabel)+kMidSpace,YF(_titleLabel), SCREEN_WIDTH-W_RATIO(50)-MaxXF(_titleLabel)-kMidSpace, HEIGHTF(_titleLabel));
    }else if (self.headImgView.image){
        self.headImgView.frame = CGRectMake(SCREEN_WIDTH-HEIGHTF(self.contentView), W_RATIO(50)/2.0,HEIGHTF(self.contentView)-W_RATIO(50), HEIGHTF(self.contentView)-W_RATIO(50));
        self.headImgView.layer.cornerRadius = WIDTHF(self.headImgView)/2.0;
    }
    
    
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        titleLabel.font = FONT(30);
        titleLabel.textColor = COLOR_666666;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        contentLabel.font = FONT(32);
        contentLabel.textColor = COLOR_333333;
        contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:contentLabel];
    }
    return _contentLabel;
}
-(UIImageView *)headImgView{
    if (!_headImgView) {
        UIImageView *headImgView = [[UIImageView alloc] init];
        _headImgView = headImgView;
        headImgView.layer.masksToBounds = YES;
        [self.contentView addSubview:headImgView];
    }
    return _headImgView;
}
-(UIImageView *)arrowImgView{
    if (!_arrowImgView) {
        UIImageView *arrowImgView = [[UIImageView alloc] init];
        _arrowImgView = arrowImgView;
        arrowImgView.hidden = YES;
        arrowImgView.image = [UIImage imageNamed:@"mianbaoxie_xi_tianziliao"];
        
        [self.contentView addSubview:arrowImgView];
    }
    return _arrowImgView;
}
-(void)setIsShowArrow:(BOOL)isShowArrow{
    _isShowArrow = isShowArrow;
    self.arrowImgView.hidden = !isShowArrow;
}
@end
