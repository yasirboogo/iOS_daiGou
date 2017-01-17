//
//  YNLogisticalMsgTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNLogisticalMsgTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@end

typedef NS_ENUM(NSInteger, LogisticalCellType) {
    FirstSatus,
    CommonStatus,
    LastStatus
};

@interface YNLogisticalCellFrame : NSObject

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,assign) CGRect msgF;

@property (nonatomic,assign) CGRect timeF;

@property (nonatomic,assign) CGRect pointF;

@property (nonatomic,assign) CGRect markF;

@property (nonatomic,assign) CGRect lineUpF;

@property (nonatomic,assign) CGRect lineDownF;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) LogisticalCellType cellType;


+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array;

@end
@interface YNLogisticalMsgCell : UITableViewCell

@property (nonatomic,strong) YNLogisticalCellFrame *cellFrame;

@property (nonatomic,assign) LogisticalCellType cellType;

@end
