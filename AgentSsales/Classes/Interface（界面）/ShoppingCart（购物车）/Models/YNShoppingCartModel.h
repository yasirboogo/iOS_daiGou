//
//  YNShoppingCartModel.h
//  AgentSsales
//
//  Created by innofive on 17/3/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "JSONModel.h"

@protocol YNShoppingCartGoodsModel;

@interface YNShoppingCartListModel : JSONModel

@property (nonatomic, strong) NSMutableArray <Optional,YNShoppingCartGoodsModel> * shoppingArray;

@property (nonatomic, assign) BOOL allSelected;

@property (nonatomic, assign) NSInteger statusIndex;

@property (nonatomic, assign) NSInteger editingCount;

@property (nonatomic, assign) NSInteger unAbleCount;

@property (nonatomic, assign) CGFloat allPrice;

@property (nonatomic, assign) NSInteger allCount;

@end
@interface YNShoppingCartGoodsModel : JSONModel

@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, assign) NSInteger shoppingId;
@property (nonatomic, copy) NSString <Optional> * name;
@property (nonatomic, copy) NSString <Optional> * img;
@property (nonatomic, copy) NSString <Optional> * salesprice;
@property (nonatomic, assign) NSInteger isdelete;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger stock;
@property (nonatomic, copy) NSString <Optional> * note;
@property (nonatomic, assign) NSInteger editCount;
@property (nonatomic, assign) BOOL editing;
@property (nonatomic, assign) BOOL selected;
@end
