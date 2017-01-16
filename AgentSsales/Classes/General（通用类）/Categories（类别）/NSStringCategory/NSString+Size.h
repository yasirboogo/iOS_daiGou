//
//  NSString+Size.h
//  AgentSsales
//
//  Created by innofive on 17/1/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)
/**
 计算文字高度
 
 @param width 视图宽度
 @param font 字体大小
 @return 尺寸
 */
-(CGSize)calculateHightWithWidth:(CGFloat)width font:(UIFont*)font;
/**
 计算文字宽度
 
 @param font 字体大小
 @param maxWidth 最大宽度
 @return 尺寸
 */
-(CGSize)calculateHightWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth;

/**
 计算文字宽度

 @param width 视图宽度
 @param font 字体大小
 @param line 行数
 @return 尺寸
 */
-(CGSize)calculateHightWithWidth:(CGFloat)width font:(UIFont*)font line:(NSInteger)line;

@end
