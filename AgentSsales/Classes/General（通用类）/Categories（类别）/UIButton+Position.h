//
//  UIButton+Position.h
//  ExerciseDiet
//
//  Created by innofive on 16/10/18.
//  Copyright © 2016年 innofive. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,ImagePosition) {
    BtnWithImgOnHorizontalRight,
    BtnWithImgVerticalAbove,
    BtnWithImgVerticalBottom,
};

@interface UIButton (Position)
/** 调整button中图片与文字的位置 */

-(void)adjustButtonForImageAndTitleWithImagePosition:(ImagePosition)imagePosition isSpace:(BOOL)isSpace;

@end
