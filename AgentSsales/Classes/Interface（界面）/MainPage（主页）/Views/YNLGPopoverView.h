//
//  YNLGPopoverView.h
//  AgentSsales
//
//  Created by innofive on 16/12/22.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNLGPopoverView : UIView

@property (nonatomic, assign) BOOL hideAfterTouchOutside; ///< 是否开启点击外部隐藏弹窗, 默认为YES.
@property (nonatomic, assign) BOOL showShade; ///< 是否显示阴影, 如果为YES则弹窗背景为半透明的阴影层, 否则为透明, 默认为NO.
//@property (nonatomic, assign) PopoverViewStyle style; //

+ (instancetype)popoverView;

@end
