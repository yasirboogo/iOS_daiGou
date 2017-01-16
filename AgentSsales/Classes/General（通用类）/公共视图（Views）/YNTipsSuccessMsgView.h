//
//  YNTipsSuccessMsgView.h
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNTipsSuccessMsgView : UIView
/** 提示信息的富文本Size(大小固定) */
@property (nonatomic,assign) CGSize msgSize;
/** 信息 */
@property (nonatomic,strong) NSDictionary * dict;

@end
