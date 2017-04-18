//
//  YNHomePageCollectionView.h
//  AgentSsales
//
//  Created by innofive on 16/12/22.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YNHomePageHeaderView;

@interface YNHomePageCollectionView : UICollectionView

@property (nonatomic,strong) NSArray *rateArray;

@property (nonatomic,strong) NSArray *adArray;

@property (nonatomic,strong) NSArray *hotArray;

@property (nonatomic,strong) NSMutableArray *dataArrayM;

/** 点击轮播广告回调 */
@property (nonatomic,copy)void(^didSelectPlayerImgClickBlock)(NSString*,NSString*);
/** 点击代购平台回调 */
@property (nonatomic,copy)void(^didSelectPlatImgClickBlock)(NSInteger);
/** 点击热门分类回调 */
@property (nonatomic,copy)void(^didSelectHotClassImgClickBlock)(NSString*,NSInteger);
/** 点击更多按钮回调 */
@property (nonatomic,copy)void(^didSelectMoreBtnClickBlock)(NSInteger);
/** 点击特色惠购回调 */
@property (nonatomic,copy)void(^didSelectGoodImgClickBlock)(NSString*);

@end


@interface YNPlayerImgCell : UICollectionViewCell
/** 滚动视图URLString */
@property (nonatomic,strong) NSArray<NSString*> * imageURLs;
/** 点击代购平台回调 */
@property (nonatomic,copy)void(^didSelectPlayerImgClickBlock)(NSInteger);

@end

@interface YNPlatSelectsCell : UICollectionViewCell
/** 代购平台图片 */
@property (nonatomic,strong) NSString * platImg;
@end

@interface YNHotClassesCell : UICollectionViewCell
/** 热门分类图片URLString 标题*/
@property (nonatomic,strong) NSDictionary* dict;
/** 点击热门分类回调 */
@property (nonatomic,copy)void(^didSelectHotClassImgClickBlock)(NSInteger);

@end
@interface YNRateTypesCell : UICollectionViewCell
/** RMB */
@property (nonatomic,weak)UILabel *rmbLabel;
/** 买进 */
@property (nonatomic,weak)UILabel *buyInLabel;
/** 卖出 */
@property (nonatomic,weak)UILabel *sellOutLabel;

@end
@interface YNMoneyRatesCell : UICollectionViewCell
/** 国旗 */
@property (nonatomic,weak)UIImageView *flagImgView;
/** 货币类型 */
@property (nonatomic,weak)UILabel *typeLabel;
/** 买进 */
@property (nonatomic,weak)UILabel *buyLabel;
/** 卖出 */
@property (nonatomic,weak)UILabel *sellLabel;

@end

@interface YNShowGoodsCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end

@interface YNSpecialBuyCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;
@property (nonatomic,copy)void(^didBuyNowButtonClickBlock)();
@end

typedef void(^moreButtonClickBlock)();

@interface YNHeaderBarView : UICollectionReusableView

@property (nonatomic,copy)moreButtonClickBlock moreButtonClickBlock;
@property (nonatomic,weak)UIImageView *leftImgView;
@property (nonatomic,weak)UILabel *titleLabel;
@property (nonatomic,weak)UIButton *moreBtn;

-(void)setWithTitle:(NSString*)title
            leftImg:(UIImage*)leftImg
            moreImg:(UIImage*)moreImg
              color:(UIColor*)color
     moreClickBlock:(moreButtonClickBlock)moreClickBlock;

@end

typedef void(^showButtonClickBlock)(BOOL);
@interface YNHeaderShowBarView : UICollectionReusableView
@property (nonatomic,copy)showButtonClickBlock showButtonClickBlock;
-(void)setWithTitle:(NSString*)title
            leftImg:(UIImage*)leftImg
            isShow:(BOOL)isShow
     showClickBlock:(showButtonClickBlock)showClickBlock;

@end
