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

@property (nonatomic,strong) NSMutableArray<NSNumber*> * selectArrayM;

@property (nonatomic,strong) NSMutableArray<NSString*> * numArrayM;

@property (nonatomic,assign) CGFloat allPrice;

@property (nonatomic,assign) NSInteger allCount;

@property (nonatomic,copy) void(^handleCellEditButtonBlock)(BOOL,NSInteger);

@property (nonatomic,assign) NSInteger allSaveCount;

@property (nonatomic,strong) NSMutableArray<NSString*> *goodsIdsArrayM;

@end
@interface YNGoodsCartCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;
/** 数量变化回调 */
@property (nonatomic,copy) void(^handleCellAddButtonBlock)(BOOL,NSInteger,NSInteger);

@property (nonatomic,copy) void(^handleCellEditButtonBlock)(BOOL);
/** 勾选回调 */
@property (nonatomic,copy) void(^didSelectedButtonClickBlock)(BOOL);
/** 是否可用 */
@property (nonatomic,assign) BOOL isEnabled;

@property (nonatomic,strong) NSString *count;
/** 是否勾选 */
@property (nonatomic,assign) BOOL isSelected;

@end
