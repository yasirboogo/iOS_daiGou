//
//  YNSelectLanguageView.h
//  AgentSsales1
//
//  Created by innofive on 17/2/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNSelectLanguageView : UITableView

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong)void(^didSelectLanguageCellBlock)(NSInteger);

@end
