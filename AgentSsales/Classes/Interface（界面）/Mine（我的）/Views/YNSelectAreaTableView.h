//
//  YNSelectAreaTableView.h
//  AgentSsales
//
//  Created by innofive on 17/4/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SelectAreaType) {
    AreaCountry,
    AreaProvinces,
    AreaCity,
    AreaDistrict
};

@interface YNSelectAreaTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,copy)void(^didSelectAddressName)(NSString*,NSString*,NSString*,NSString*,NSString*);

@end
