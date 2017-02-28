//
//  YNAreaSelectView.h
//  AgentSsales1
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNAreaSelectView : UIView

@property (nonatomic, assign) BOOL isTapGesture;

@property (nonatomic,copy) void(^didSelectAreaSelectResultBlock)(NSString *);

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;

@end
@interface YNAreaSelectCell : UICollectionViewCell

@property (nonatomic,copy) NSString * title;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,assign) CGRect tableFrame;

@property (nonatomic,assign) CGRect headerFrame;

@property (nonatomic,copy) void(^didSelectAreaSelectCellBlock)(NSInteger index);

@end
