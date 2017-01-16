//
//  YNUpdateInforTableView.h
//  AgentSsales
//
//  Created by innofive on 16/12/30.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNUpdateInforTableView : UITableView

@property (nonatomic,copy) void(^didSelectUpdateInforClickBlock)(NSString*);

@end

@interface YNUpdateInforCell : UITableViewCell
/** 左边文字 */
@property (nonatomic,weak) UILabel *titleLabel;
/** 右边内容 */
@property (nonatomic,weak) UILabel *contentLabel;
/** 箭头符号 */
@property (nonatomic,weak) UIImageView *arrowImgView;
/** 箭头符号隐藏 */
@property (nonatomic,assign) BOOL isShowArrow;
/** 头像 */
@property (nonatomic,weak) UIImageView *headImgView;

@end
