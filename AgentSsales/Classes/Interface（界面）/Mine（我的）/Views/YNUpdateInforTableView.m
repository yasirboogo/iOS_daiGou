//
//  YNUpdateInforTableView.m
//  AgentSsales
//
//  Created by innofive on 16/12/30.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNUpdateInforTableView.h"

@interface YNUpdateInforTableView()<UITableViewDataSource,UITableViewDelegate>

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
    }
    return self;
}
-(void)setInforDict:(NSDictionary *)inforDict{
    _inforDict = inforDict;
    _inforArray = @[@{@"title":LocalHeadImg,@"content":inforDict[@"headimg"]},
                    @{@"title":LocalNickName,@"content":inforDict[@"nickname"]},
                    @{@"title":LocalRecPhone,@"content":inforDict[@"loginphone"]},
                    @{@"title":LocalCardID,@"content":inforDict[@"idcardId"]},
                    @{@"title":LocalAccountSafe,@"content":LocalChangePwd},
                    ];
    [self reloadData];
    
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
        [inforCell.headImgView sd_setImageWithURL:_inforArray[indexPath.row][@"content"] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
        inforCell.isForbidClick = YES;
        [inforCell setDidSelectChangeImgBlock:^{
            self.didSelectChangeImgBlock();
        }];
    }else{
        if (indexPath.row == 2||indexPath.row == 4) {
            inforCell.isShowArrow = YES;
            inforCell.isForbidClick = YES;
        }
        inforCell.titleLabel.text = _inforArray[indexPath.row][@"title"];
        inforCell.contentTField.text = _inforArray[indexPath.row][@"content"];
    }
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        if (indexPath.row == 1) {
            self.nickname = str;
        }else if (indexPath.row == 3){
            self.idcardId = str;
        }
    }];
    return inforCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2||indexPath.row == 4) {
        if (self.didSelectUpdateInforClickBlock) {
            self.didSelectUpdateInforClickBlock(indexPath.row);
        }
    }
}
-(NSString *)nickname{
    if (!_nickname) {
        _nickname = self.inforArray[1][@"content"];
    }
    return _nickname;
}
-(NSString *)idcardId{
    if (!_idcardId) {
        _idcardId = self.inforArray[3][@"content"];
    }
    return _idcardId;
}
@end

@implementation YNUpdateInforCell

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.titleLabel.frame = CGRectMake(kMidSpace, 0, titleSize.width, HEIGHTF(self.contentView));
    self.arrowImgView.frame = CGRectMake(SCREEN_WIDTH-(W_RATIO(50)+W_RATIO(12))/2.0,(HEIGHTF(self.contentView)-W_RATIO(22))/2.0, W_RATIO(12), W_RATIO(22));
    
    if (self.headImgView.image) {
        self.headImgView.frame = CGRectMake(SCREEN_WIDTH-HEIGHTF(self.contentView), W_RATIO(50)/2.0,HEIGHTF(self.contentView)-W_RATIO(50), HEIGHTF(self.contentView)-W_RATIO(50));
        self.headImgView.layer.cornerRadius = WIDTHF(self.headImgView)/2.0;
    }else{
        self.contentTField.frame = CGRectMake(MaxXF(_titleLabel)+kMidSpace,YF(_titleLabel), SCREEN_WIDTH-W_RATIO(50)-MaxXF(_titleLabel)-kMidSpace, HEIGHTF(_titleLabel));
    }

}
-(void)setIsForbidClick:(BOOL)isForbidClick{
    _isForbidClick = isForbidClick;
    self.contentTField.enabled = !isForbidClick;
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
-(UITextField *)contentTField{
    if (!_contentTField) {
        UITextField *contentTField = [[UITextField alloc] init];
        _contentTField = contentTField;
        [self.contentView addSubview:contentTField];
        contentTField.font = FONT(32);
        contentTField.textColor = COLOR_333333;
        contentTField.textAlignment = NSTextAlignmentRight;
        [contentTField addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _contentTField;
}
-(UIImageView *)headImgView{
    if (!_headImgView) {
        UIImageView *headImgView = [[UIImageView alloc] init];
        _headImgView = headImgView;
        headImgView.layer.masksToBounds = YES;
        [self.contentView addSubview:headImgView];
        headImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChangeImg)];
        [headImgView addGestureRecognizer:tap];
    }
    return _headImgView;
}
-(void)handleChangeImg{
    if (self.didSelectChangeImgBlock) {
        self.didSelectChangeImgBlock();
    }
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return textField.enabled;
}
#pragma mark - private method
- (void)textfieldTextDidChange:(UITextField *)textField
{
    if (self.inforCellTextFieldBlock) {
        self.inforCellTextFieldBlock(_contentTField.text);
    }
}
@end
