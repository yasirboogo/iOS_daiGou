//
//  CZBeginView.m
//  gz3Weibo
//
//  Created by apple on 15/7/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PDBeginView.h"
#import "YNTabBarController.h"
#import "PDVersionTool.h"
@implementation PDBeginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)beginView{
    return [[[NSBundle mainBundle] loadNibNamed:@"PDBeginView" owner:nil options:nil] lastObject];
}
- (IBAction)beginBtnClick:(id)sender {
    [PDVersionTool saveVersionToSandbox];
    YNTabBarController *tab = [[YNTabBarController alloc]init];
//    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = tab;
}

@end
