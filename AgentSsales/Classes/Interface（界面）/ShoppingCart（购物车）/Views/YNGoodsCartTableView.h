//
//  YNGoodsCartTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsCartTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;;

@end
@interface YNGoodsCartCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
