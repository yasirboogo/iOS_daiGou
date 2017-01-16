//
//  NSString+Size.m
//  AgentSsales
//
//  Created by innofive on 17/1/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
-(CGSize)calculateHightWithWidth:(CGFloat)width font:(UIFont*)font{
    
    return CGSizeMake(width, [self boundingRectWithSize:CGSizeMake(width , CGFLOAT_MAX)
                                               options:(NSStringDrawingUsesLineFragmentOrigin)
                                            attributes:@{NSFontAttributeName:font}
                                               context:nil].size.height);
}
-(CGSize)calculateHightWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth{
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat width = size.width <= maxWidth ? size.width : maxWidth;
    if (maxWidth == 0) {
        return size;
    }else{
        return CGSizeMake(width,[self sizeWithAttributes:@{NSFontAttributeName:font}].height);
    }
}
-(CGSize)calculateHightWithWidth:(CGFloat)width font:(UIFont *)font line:(NSInteger)line{
    CGSize size1 = [self calculateHightWithWidth:width font:font];
    CGSize size2 = [self calculateHightWithFont:font maxWidth:0];
    CGFloat hight = (size1.height <= line*size2.height) ? size1.height : line*size2.height;
    if (line == 0) {
        return size2;
    }
    return CGSizeMake(width, hight);
}
@end
