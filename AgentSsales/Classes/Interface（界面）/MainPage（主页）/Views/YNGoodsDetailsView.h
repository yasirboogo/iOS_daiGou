//
//  YNGoodsDetailsView.h
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsDetailsView : UIView

@property (nonatomic,copy) NSDictionary *dataDict;

@property (nonatomic,copy) void(^didSelectPlayerImgClickBlock)(NSString*);

@property (nonatomic,copy) void(^didSelectShareButtonClickBlock)();

@end
@interface YNDetailImgCellFrame : NSObject

@property (nonatomic,copy) NSString * imgUrl;

@property (nonatomic,assign) CGFloat cellHeight;

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array;

@end
@interface YNDetailImgCell : UITableViewCell

@property (nonatomic,copy) YNDetailImgCellFrame * cellFrame;

@end
@interface YNDetailVideoCell : UITableViewCell

@property (nonatomic,copy) NSString * videoUrl;

@end
