//
//  YNUserInforCell.h
//  AgentSsales
//
//  Created by innofive on 17/1/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNUserInforCell : UITableViewCell
/** block 参数为textField.text */
@property (nonatomic,copy) void(^inforCellTextFieldBlock)(NSString*);
/** block 验证码启动 */
@property (nonatomic,copy) void(^didSendPhoneCodeButtonBlock)();
/** 参数 */
@property (nonatomic,strong) NSDictionary *inforDict;
/** 标题 */
@property (nonatomic,weak) UILabel *titleLabel;
/** 是否显示验证码按钮 */
@property (nonatomic,assign) BOOL isShowCodeBtn;
//输入框内容
@property (nonatomic,copy) NSString *textFieldText;

@property (nonatomic,assign) BOOL isShowText;
/** 是否显示右箭头 */
@property (nonatomic,assign) BOOL isShowArrowImg;
@property (nonatomic,assign) BOOL isForbidClick;
/** 键盘类型 */
@property (nonatomic,assign) UIKeyboardType keyboardType;

@end
