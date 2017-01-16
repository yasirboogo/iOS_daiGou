//
//  CZNewFeatureViewController.m
//  gz3Weibo
//
//  Created by apple on 15/7/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PDNewFeatureViewController.h"
#import "UIView+Extension.h"
#import "PDBeginView.h"

@interface PDNewFeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *pageContr;
@end

@implementation PDNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加4张图片 到UIScrollView
    //new_feature_1
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    // 设置翻页
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    // 隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    // 图片尺寸
    CGSize imgSize = scrollView.bounds.size;
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        NSString *imgName = [NSString stringWithFormat:@"new_future_%ld",i+1];
        imgView.image =[UIImage imageWithFileName:imgName];
        
        // 设置imgview的frm
        CGFloat imgX = i * imgSize.width;
//        imgView.frame = CGRectMake(imgX, 0, imgSize.width, imgSize.height);
        imgView.frame = (CGRect){imgX,0,imgSize};
        
        [scrollView addSubview:imgView];
        
        // 最后一页 添加 BeginView
        if(i == 2){
            imgView.userInteractionEnabled = YES;
            PDBeginView *beginView = [PDBeginView beginView];
            CGFloat bvCenterX = imgSize.width * 0.5;
            CGFloat bvCenterY = imgSize.height - 150;
            beginView.center = CGPointMake(bvCenterX, bvCenterY);
            [imgView addSubview:beginView];
        }
        
    }
    
    //  设置scrollView内容尺寸
    scrollView.contentSize = CGSizeMake(imgSize.width * 3, imgSize.height);
    
    
    // 页数提示
    CGFloat pcMargin = 60;
    CGFloat pcH = 30;
    CGFloat pcW = imgSize.width;
    CGFloat pcY = imgSize.height - pcMargin - pcH;
    UIPageControl *pageContr = [[UIPageControl alloc] init];
    pageContr.frame = CGRectMake(0, pcY, pcW, pcH);
//    pageContr.backgroundColor = [UIColor lightGrayColor];
    pageContr.numberOfPages = 3;
    
    // 设置颜色
    pageContr.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageContr.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.view addSubview:pageContr];
    self.pageContr = pageContr;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    // 设置页码
    NSInteger crrentPage = scrollView.contentOffset.x /scrollView.w;
    
//        NSLog(@"%ld",crrentPage);
    self.pageContr.currentPage = crrentPage;
}

@end
