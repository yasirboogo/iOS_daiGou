//
//  YNAddressTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNAddressTableView : UITableView

@property (nonatomic,strong) NSMutableArray * dataArrayM;

@property (nonatomic,copy) void(^didSelectAddressCellBlock)(NSIndexPath*);

@property (nonatomic,copy) void(^didSelectSetDefaultAddressBlock)(NSInteger);

@property (nonatomic,copy) void(^didSelectSetDelectAddressBlock)(NSInteger);

@end

@interface YNAddressCellFrame : NSObject

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect phoneF;
@property (nonatomic,assign) CGRect addresssF;
@property (nonatomic,assign) CGRect selectBtnF;
@property (nonatomic,assign) CGRect selectF;
@property (nonatomic,assign) CGRect delectBtnF;
@property (nonatomic,assign) CGRect delectF;
@property (nonatomic,assign) CGRect bgViewF;

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array;
@end

@interface YNAddressCell : UITableViewCell

@property (nonatomic,copy) void(^didSelectButtonClickBlock)();

@property (nonatomic,copy) void(^didDelectButtonClickBlock)();

@property (nonatomic,strong) YNAddressCellFrame * cellFrame;

@property (nonatomic,assign) BOOL isSelect;

@end
