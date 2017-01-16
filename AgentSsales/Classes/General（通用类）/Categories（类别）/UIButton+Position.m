//
//  UIButton+Position.m
//  ExerciseDiet
//
//  Created by innofive on 16/10/18.
//  Copyright © 2016年 innofive. All rights reserved.
//

#import "UIButton+Position.h"

@implementation UIButton (Position)
-(void)adjustButtonForImageAndTitleWithImagePosition:(ImagePosition)imagePosition isSpace:(BOOL)isSpace{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    
    
    
    CGFloat space = (self.frame.size.height -imageSize.height - titleSize.height)/6.0;
    space = (isSpace && space > 0) ? space : 0;
    switch (imagePosition) {
        case BtnWithImgOnHorizontalRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-imageSize.width-titleSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0,-imageSize.width-titleSize.width, 0, 0);
            break;
        case BtnWithImgVerticalAbove:
            self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height+space), 0, 0, - titleSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height+space), 0);
            break;
        case BtnWithImgVerticalBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(0,0,- (titleSize.height+space), - titleSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(- (imageSize.height+space),- imageSize.width, 0, 0);
            break;
        default:
            break;
    }
}



@end
