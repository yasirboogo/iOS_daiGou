//
//  UIView+CornerRadius.m
//  AgentSsales
//
//  Created by innofive on 17/1/15.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)



-(UIView*)setViewCornerRadiusWithRectCorner:(UIRectCorner)rectCorner cornerSize:(CGSize)cornerSize{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}

@end
