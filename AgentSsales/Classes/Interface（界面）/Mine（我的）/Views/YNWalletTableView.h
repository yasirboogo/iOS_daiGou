//
//  YNWalletTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNWalletTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,assign) BOOL isHaveLine;

@property (nonatomic,strong) NSArray<NSString*> * itemTitles;

@end
@interface YNWalletTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
