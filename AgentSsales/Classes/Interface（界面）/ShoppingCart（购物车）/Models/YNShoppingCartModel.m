//
//  YNShoppingCartModel.m
//  AgentSsales
//
//  Created by innofive on 17/3/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNShoppingCartModel.h"

@implementation YNShoppingCartListModel

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        //self.idMark = [dict objectForKey:@"id"];
    }
    return self;
    
}

@end
@implementation YNShoppingCartGoodsModel

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        //self.idMark = [dict objectForKey:@"id"];
    }
    return self;
    
}

@end
