//
//  YNGoodsDetailsView.h
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsDetailsView : UIView

@property (nonatomic,copy) NSDictionary *dict;

@property (nonatomic,copy) NSArray<NSString*> * imageURLs;

@property (nonatomic,copy) void(^didSelectPlayerImgClickBlock)(NSString*);

@property (nonatomic,copy) void(^didSelectShareButtonClickBlock)();

@end
