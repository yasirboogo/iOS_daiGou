//
//  YNChangeMoneyView.m
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNChangeMoneyView.h"

@interface YNChangeMoneyView ()

@end

@implementation YNChangeMoneyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = W_RATIO(20);
    }
    return self;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self addSubview:nameLabel];
        nameLabel.font = FONT(26);
        nameLabel.frame = CGRectMake(kMidSpace, kMinSpace*3, WIDTHF(self)-kMidSpace*2, W_RATIO(30));
    }
    return _nameLabel;
}











@end
