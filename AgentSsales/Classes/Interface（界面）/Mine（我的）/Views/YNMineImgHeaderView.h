//
//  YNMineImgHeaderView.h
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNMineImgHeaderView : UIView

@property (nonatomic,copy) NSString * topNumber;
@property (nonatomic,copy) NSString * leftNumber;
@property (nonatomic,copy) NSString * rightNumber;

@property (nonatomic,strong) UIImageView * bgImgView;
/** 标题一 */
@property (nonatomic,weak) UILabel * topTitleLabel;
/** 标题二 */
@property (nonatomic,weak) UILabel * leftTitleLabel;
/** 标题三 */
@property (nonatomic,weak) UILabel * rightTitleLabel;

@end
