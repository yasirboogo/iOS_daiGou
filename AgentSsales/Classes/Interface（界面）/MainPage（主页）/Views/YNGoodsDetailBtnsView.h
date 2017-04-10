//
//  YNGoodsDetailBtnsView.h
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsDetailBtnsView : UIView

@property (nonatomic,copy) NSString * price;

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,copy) void(^didSelectAddCartButtonClickBlock)();

@property (nonatomic,copy) void(^didSelectBuyButtonClickBlock)();

@end
