//
//  BaseViewController.h
//  YiQiGanDianSha
//
//  Created by mac on 15/10/5.
//  Copyright (c) 2015年 CH. All rights reserved.
//  基类ViewController

#import <UIKit/UIKit.h>

@interface YNBaseViewController : UIViewController
/**  nav背景view */
@property (nonatomic, strong) UIView *navView;
/**  左边的button */
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, assign) NSInteger pageSize;

/**
 给导航栏添加纯图片按钮

 @param img 正常图片
 @param selectImg 选中图片
 @param isOnRight 是否在右边，默认是右边
 @param btnClickBlock 点击按钮的回调
 @return 返回该按钮
 */
-(UIButton*)addNavigationBarBtnWithImg:(UIImage*)img
                        selectImg:(UIImage*)selectImg
                        isOnRight:(BOOL)isOnRight
                         btnClickBlock:(void(^)(BOOL isShow))btnClickBlock;

/**
  给导航栏添加纯文字按钮

 @param title 正常文字
  @param selectTitle 选中文字
 @param font 字体大小
 @param isOnRight 是否在右边，默认是右边
 @param btnClickBlock 点击按钮的回调
 @return 返回该按钮
 */
-(UIButton*)addNavigationBarBtnWithTitle:(NSString*)title
                             selectTitle:(NSString*)selectTitle
                                    font:(UIFont*)font
                               isOnRight:(BOOL)isOnRight
                           btnClickBlock:(void(^)(BOOL isShow))btnClickBlock;

-(UIButton*)addNavigationBarBtnWithTitle:(NSString*)title
                             selectTitle:(NSString*)selectTitle
                                    font:(UIFont*)font
                                     img:(UIImage*)img
                               selectImg:(UIImage*)selectImg
                                imgWidth:(CGFloat)imgWidth
                               isOnRight:(BOOL)isOnRight
                           btnClickBlock:(void(^)(BOOL isShow))btnClickBlock;
/**  左边按钮方法 */
- (void)backMethod;
/**  ui布局 */
- (void)makeUI;
/**  导航栏布局 */
- (void)makeNavigationBar;
/**  数据初始化 */
- (void)makeData;
@end
@interface YNNavigationBarButton : UIButton

@property (nonatomic,copy)void(^navigationBarButtonClickBlock)(BOOL);

@end
