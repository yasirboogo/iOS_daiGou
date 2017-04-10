//
//  YNCouponTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/18.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNCouponTableView : UITableView

@property (nonatomic,strong) NSMutableArray * dataArrayM;

@property (nonatomic,assign) BOOL isInvalid;

@property (nonatomic,copy) NSString *allPrice;

@property (nonatomic,copy) void(^didSelectUseButtonBlock)(NSString*,NSString*);

@end
typedef NS_ENUM(NSInteger, YNCouponCellType) {
    RedType,
    BlueType,
    GrayType
};

@interface YNCouponCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,assign) YNCouponCellType cellType;

@property (nonatomic,assign) BOOL isShowUse;

@property (nonatomic,copy) void(^didSelectUseButtonBlock)();

@end
