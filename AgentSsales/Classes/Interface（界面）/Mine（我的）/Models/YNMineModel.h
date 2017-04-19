//
//  YNMineModel.h
//  AgentSsales1
//
//  Created by innofive on 17/2/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "JSONModel.h"

@protocol MyOrderGoodsModel;
@interface MyOrderListModel : JSONModel

@property (nonatomic,copy) NSString<Optional> * orderstatus;

@property (nonatomic,copy) NSString<Optional> * orderId;

@property (nonatomic,copy) NSString<Optional> * type;

@property (nonatomic,copy) NSString<Optional> * ordernumber;

@property (nonatomic,copy) NSString<Optional> * totalprice;

@property (nonatomic,copy) NSString<Optional> * postage;

@property (nonatomic,strong) NSArray<Optional,MyOrderGoodsModel> * goodsArray;

@end
@interface MyOrderGoodsModel : JSONModel

@property (nonatomic,copy) NSString<Optional> * name;

@property (nonatomic,copy) NSString<Optional> * img;

@property (nonatomic,copy) NSString<Optional> * salesprice;

@property (nonatomic,copy) NSString<Optional> * note;

@property (nonatomic,copy) NSString<Optional> * count;

@property (nonatomic,copy) NSString<Optional> * type;

@end

