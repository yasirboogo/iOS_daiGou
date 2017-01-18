//
//  YNCouponTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/18.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNCouponTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,assign) BOOL isInvalid;

@end
typedef NS_ENUM(NSInteger, YNCouponCellType) {
    RedType,
    BlueType,
    GrayType
};

@interface YNCouponCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,assign) YNCouponCellType cellType;

@end
