//
//  NSString+Category.m
//  ExerciseDiet
//
//  Created by innofive on 16/10/18.
//  Copyright © 2016年 innofive. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

-(CGFloat)calculateHightWithWidth:(CGFloat)width Font:(UIFont*)font{
    
    return [self boundingRectWithSize:CGSizeMake(width , CGFLOAT_MAX)
                              options:(NSStringDrawingUsesLineFragmentOrigin)
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size.height+W_RATIO(30)*2;;
}

@end
