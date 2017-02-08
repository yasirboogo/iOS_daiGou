//
//  YSearchHistoryView.h
//  AgentSsales
//
//  Created by innofive on 17/2/7.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSearchHistoryView : UIView

@property (nonatomic,copy) NSString * searchContent;

@property (nonatomic,copy)void(^didSelectSearchHistoryCellBlock)(NSString*);

@end
@interface YNSearchHistoryCell : UICollectionViewCell

@property (nonatomic,copy) NSString * searchContent;

@end
@interface YNHistoryModel : JKDBModel

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *searchContent;

@property (nonatomic,copy) NSString *sordId;

@end
