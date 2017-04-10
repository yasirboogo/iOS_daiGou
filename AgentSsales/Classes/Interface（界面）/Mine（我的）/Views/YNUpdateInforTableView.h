//
//  YNUpdateInforTableView.h
//  AgentSsales
//
//  Created by innofive on 16/12/30.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNUpdateInforTableView : UITableView

@property (nonatomic,copy) void(^didSelectUpdateInforClickBlock)(NSInteger);

@property (nonatomic,copy) void(^didSelectChangeImgBlock)();

@property (nonatomic,copy) NSString *nickname;

@property (nonatomic,copy) NSString *idcardId;

@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

@property (nonatomic,strong) NSDictionary *inforDict;

@end

@interface YNUpdateInforCell : UITableViewCell
/** block 参数为textField.text */
@property (nonatomic,copy) void(^inforCellTextFieldBlock)(NSString*);
/** 左边文字 */
@property (nonatomic,weak) UILabel *titleLabel;
/** 右边内容 */
@property (nonatomic,weak) UITextField *contentTField;
/** 箭头符号 */
@property (nonatomic,weak) UIImageView *arrowImgView;
/** 箭头符号隐藏 */
@property (nonatomic,assign) BOOL isShowArrow;
/** 头像 */
@property (nonatomic,weak) UIImageView *headImgView;

@property (nonatomic,copy) void(^didSelectChangeImgBlock)();

@property (nonatomic,assign) BOOL isForbidClick;
/** 键盘类型 */
@property (nonatomic,assign) UIKeyboardType keyboardType;

@end
