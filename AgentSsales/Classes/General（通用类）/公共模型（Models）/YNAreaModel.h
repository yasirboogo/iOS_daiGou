//
//  YNAreaModel.h
//  AgentSsales1
//
//  Created by innofive on 17/2/9.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "JSONModel.h"

@protocol YNChinaCityModel;

@protocol YNChinaDistrictModel;

@interface YNChinaProvinceModel : JSONModel

@property (nonatomic,copy) NSString <Optional> * province;

@property (nonatomic,copy) NSArray<Optional,YNChinaCityModel> * cityList;

@end
@interface YNChinaCityModel : JSONModel

@property (nonatomic,copy) NSString * city;

@property (nonatomic,copy) NSArray<Optional,YNChinaDistrictModel> * districtList;

@end
@interface YNChinaDistrictModel : JSONModel

@property (nonatomic,copy) NSString * district;

@end
