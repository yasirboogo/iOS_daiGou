//
//  PDNavBaseViewController.m
//
//
//  Created by BeNnY on 15/9/12.
//  Copyright (c) 2015年 PanDong. All rights reserved.
//

#import "YNBaseNavViewController.h"


@interface YNBaseNavViewController ()

@end

@implementation YNBaseNavViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
