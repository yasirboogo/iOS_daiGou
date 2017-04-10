//
//  YNPhoneAreaCodeView.h
//  AgentSsales1
//
//  Created by innofive on 17/2/9.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNPhoneAreaCodeView : UIView


@property (nonatomic, assign) BOOL isTapGesture;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) void(^didSelectCodeCellBlock)(NSInteger);

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;


@end
@interface YNPhoneAreaCodeCell : UITableViewCell

@property (nonatomic,copy) NSString * country;

@property (nonatomic,assign) BOOL isSelect;

@end
