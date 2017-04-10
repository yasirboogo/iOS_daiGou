//
//  YNGoodsCartTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsCartTableView : UITableView

//@property (nonatomic,strong) NSMutableArray * dataArrayM;

@property (nonatomic,strong) YNShoppingCartListModel * shoppingCartListModel;

//@property (nonatomic,strong) NSMutableArray<NSNumber*> * selectArrayM;

//@property (nonatomic,strong) NSMutableArray<NSString*> * numArrayM;

@property (nonatomic,assign) CGFloat allPrice;

@property (nonatomic,assign) NSInteger allCount;

@property (nonatomic,copy) void(^handleCellEditButtonBlock)(NSInteger);

@property (nonatomic,copy) void(^didSelectCellBlock)(NSInteger);

//@property (nonatomic,assign) NSInteger allSaveCount;

//@property (nonatomic,strong) NSMutableArray<NSString*> *goodsIdsArrayM;

@end
@interface YNGoodsCartCell : UITableViewCell
/** 数量变化回调 */
@property (nonatomic,copy) void(^handleCellAddButtonBlock)(NSInteger);
/** 编辑回调 */
@property (nonatomic,copy) void(^handleCellEditButtonBlock)(BOOL);
/** 勾选回调 */
@property (nonatomic,copy) void(^didSelectedButtonClickBlock)(BOOL);
/** 点击回调 */
@property (nonatomic,copy) void(^didSelectedGoodsCellBlock)();

@property (nonatomic,strong) YNShoppingCartGoodsModel *shoppingCartGoodsModel;

@end
