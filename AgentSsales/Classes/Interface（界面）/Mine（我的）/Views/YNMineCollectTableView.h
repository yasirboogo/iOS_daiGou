//
//  YNMineCollectTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNMineCollectTableView : UITableView

@property (nonatomic,strong) NSMutableArray<NSNumber*> * selectArrayM;

@property (nonatomic,strong) NSArray<NSDictionary*> * dataArray;
/** 是否编辑 */
@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,copy) void(^didSelectMineCollectCellBlock)(NSString*);

@end

@interface YNMineCollectCell : UITableViewCell
/** 勾选回调 */
@property (nonatomic,copy) void(^didSelectedButtonClickBlock)(BOOL);
/** 是否勾选 */
@property (nonatomic,assign) BOOL isSelected;
/** 是否编辑 */
@property (nonatomic,assign) BOOL isEdit;
/** 是否无效 */
@property (nonatomic,assign) BOOL isInvalid;
/** 数据模型 */
@property (nonatomic,strong) NSDictionary *cellDict;
/** 左边图片 */
@property (nonatomic,strong) UIImageView * leftImgView;
/** 标题 */
@property (nonatomic,strong) UILabel * titleLabel;
/** 版本号 */
@property (nonatomic,strong) UILabel * versionLabel;
/** 价格 */
@property (nonatomic,strong) UILabel * priceLabel;

@end
