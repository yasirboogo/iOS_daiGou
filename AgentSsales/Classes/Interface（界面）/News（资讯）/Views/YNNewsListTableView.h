//
//  YNNewsListTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNNewsListTableView : UITableView

@property (nonatomic,strong) NSMutableArray * dataArrayM;

@property (nonatomic,strong) NSDictionary * imgInfor;

@property (nonatomic,strong) NSMutableArray * adArrayM;

@property (nonatomic,copy) void(^didSelectNewsListCellBlock)(NSString*);

@property (nonatomic,copy) void(^didSelectAdCellBlock)(NSString*,NSString*);

@end

@interface YNNewsListCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNNewsAdCell : UITableViewCell

@property (nonatomic,strong) NSString * imageUrl;

@end
