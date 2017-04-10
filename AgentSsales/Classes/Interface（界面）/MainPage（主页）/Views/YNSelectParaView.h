//
//  YNSelectParaView.h
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNSelectParaView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger maxNum;

@property (nonatomic, strong) NSMutableArray<NSIndexPath*> *selectArrayM;

@property (nonatomic, assign) BOOL isTapGesture;

@property (nonatomic, copy) void(^didSelectSubmitButtonBlock)(NSString*,NSString*,CGFloat);

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;

@end
@interface YNSelectParaViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString * parameter;
@property (nonatomic,assign) BOOL isSelect;
@end
@interface YNSelectCountViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString * count;
@property (nonatomic, assign) NSInteger maxNum;
@property (nonatomic, copy) void(^didChangeCountBlock)(NSString*);
@end
@interface YNSelectParaHeaderView : UICollectionReusableView
@property (nonatomic,copy) NSString * title;
@end
