//
//  YNGoodsCartTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsCartTableView : UITableView

@property (nonatomic,strong) NSMutableArray<NSMutableDictionary*> * dataArrayM;

@end
@interface YNGoodsCartCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;
/** 数量变化回调 */
@property (nonatomic,copy) void(^handleCellAddButtonBlock)(NSInteger);

/** 勾选回调 */
@property (nonatomic,copy) void(^didSelectedButtonClickBlock)(BOOL);
/** 是否可用 */
@property (nonatomic,assign) BOOL isEnabled;

/** 是否勾选 */
@property (nonatomic,assign) BOOL isSelected;

@end
