//
//  YNNewsCommentTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/23.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNNewsCommentTableView : UITableView

@property (nonatomic,strong) NSMutableArray * dataArrayM;

@end
@interface YNNewsCommentCellFrame : NSObject

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,assign) CGRect icoF;

@property (nonatomic,assign) CGRect nameF;

@property (nonatomic,assign) CGRect timeF;

@property (nonatomic,assign) CGRect contentF;

@property (nonatomic,assign) CGFloat cellHeight;

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array;

@end
@interface YNNewsCommentCell : UITableViewCell

@property (nonatomic,strong) YNNewsCommentCellFrame * cellFrame;

@end
