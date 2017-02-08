//
//  YNSelectParaView.h
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNSelectParaView : UIView

@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, assign) BOOL isTapGesture;

@property (nonatomic, copy) void(^didSelectSubmitButtonBlock)();

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;

@end
