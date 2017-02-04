//
//  YNNewsCommentSendView.h
//  AgentSsales
//
//  Created by innofive on 17/2/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNNewsCommentSendView : UIView

@property (nonatomic,copy) void(^didSelectSendButtonClickBlock)(NSString*);

@end
