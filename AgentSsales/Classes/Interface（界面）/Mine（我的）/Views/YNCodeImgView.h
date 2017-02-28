//
//  YNCodeImgView.h
//  AgentSsales
//
//  Created by innofive on 17/2/22.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNCodeImgView : UIView

@property (nonatomic,strong) UIImage * codeImg;

@property (nonatomic,copy) void(^didSelectShareCodeImgButtonBlock)();

@end
