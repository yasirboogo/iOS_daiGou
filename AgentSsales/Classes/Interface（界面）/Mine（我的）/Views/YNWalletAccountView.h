//
//  YNWalletAccountView.h
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNWalletAccountView : UIView

@property (nonatomic,copy) NSString * accountNumber;

@property (nonatomic,copy) void(^accountTextFieldBlock)(NSString *);

@property (nonatomic,copy) void(^tipsLabelClickBlock)(void);

@property (nonatomic,copy) NSString *leftMomeyType;

@property (nonatomic,copy) void(^didSelectLeftShowButtonBlock)(BOOL);

@property (nonatomic,copy) NSString *rightMarkType;

@property (nonatomic,assign) BOOL isShow;

@end
