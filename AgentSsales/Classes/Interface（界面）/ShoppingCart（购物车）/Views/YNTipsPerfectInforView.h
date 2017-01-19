//
//  YNTipsPerfectInforView.h
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNTipsPerfectInforView : UIView

-(instancetype)initWithFrame:(CGRect)frame img:(UIImage*)img title:(NSString*)title tips:(NSString*)tips btnTitle:(NSString*)btnTitle;

@property (nonatomic, assign) BOOL isTapGesture;

@property (nonatomic, copy) void(^didSelectSubmitButtonBlock)();

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;

@end
