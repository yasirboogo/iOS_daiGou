//
//  YNTipsSuccessBtnsView.h
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, UIButtonStyle) {
    UIButtonStyle1,
    UIButtonStyle2
};

@interface YNTipsSuccessBtnsView : UIView

@property (nonatomic,strong) NSArray<NSString*> * btnTitles;

@property (nonatomic,copy) void(^didSelectBottomButtonClickBlock)(NSString*);

@property (nonatomic,assign) UIButtonStyle btnStyle;

@end
