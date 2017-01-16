//
//  YNBaseNavViewController.m
//
//  Created by 英诺 on 16/8/17.
//  Copyright © 2016年 Dream. All rights reserved.
//
#import "YNBaseNavViewController.h"
#import "YNTabBarController.h"
#import "YNBaseViewController.h"

@interface YNTabBarController ()

@end
@implementation YNTabBarController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *controllers = @[@"YNHomePageViewController",
                     @"YNNewsViewController",
                     @"YNShoppingCartViewController",
                     @"YNMineViewController"];
    NSArray *titles = @[@"home",
                        @"news",
                        @"shop",
                        @"mine"];
    NSArray *images = @[@"shouye_kui",
                        @"zixun_kui",
                        @"gouwuche_kui",
                        @"wode_kui"];
    NSArray *selectedImages = @[@"shouye_hong",
                                @"zixun_hong",
                                @"gouwuche_hong",
                                @"wode_hong"];
    
    for (NSInteger i =0; i < controllers.count; i++) {
        YNBaseViewController *baseVC = [[NSClassFromString(controllers[i]) alloc] init];
        baseVC.backButton.hidden = YES;
        [self addChildViewController:baseVC withTitle:NSLS(titles[i],@"标题")
                               image:[UIImage imageNamed:images[i]]
                       selectedImage:[UIImage imageNamed:selectedImages[i]]];
        
    }

    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setTintColor:COLOR_DF463E];
    
}
- (void)addChildViewController:(UIViewController *)childViewController withTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    // 子控制器标题
    childViewController.title = title;
    // 子控制器图片
    childViewController.tabBarItem.image = image;
    // 图片渲染模式 -> 根据原图渲染
    if (iOS7)
    {
        childViewController.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childViewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        childViewController.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childViewController.tabBarItem.selectedImage = selectedImage;
    }
    
    // 添加导航控制器
    YNBaseNavViewController *navigationController = [[YNBaseNavViewController alloc] initWithRootViewController:childViewController];
    
    [self addChildViewController:navigationController];
}


@end
