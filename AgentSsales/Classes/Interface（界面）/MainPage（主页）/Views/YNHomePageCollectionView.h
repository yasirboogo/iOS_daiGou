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


@property (nonatomic,strong) NSArray *dataArray;
/** 点击轮播广告回调 */
@property (nonatomic,copy)void(^didSelectPlayerImgClickBlock)(NSString*);
/** 点击代购平台回调 */
@property (nonatomic,copy)void(^didSelectPlatImgClickBlock)(NSString*);
/** 点击热门分类回调 */
@property (nonatomic,copy)void(^didSelectHotClassImgClickBlock)(NSString*);
/** 点击更多按钮回调 */
@property (nonatomic,copy)void(^didSelectMoreBtnClickBlock)(NSString*);
/** 点击特色惠购回调 */
@property (nonatomic,copy)void(^didSelectGoodImgClickBlock)(NSString*);

@end


@interface YNPlayerImgCell : UICollectionViewCell
/** 滚动视图URLString */
@property (nonatomic,strong) NSArray<NSString*> * imageURLs;
/** 点击代购平台回调 */
@property (nonatomic,copy)void(^didSelectPlayerImgClickBlock)(NSString*);

@end

@interface YNPlatSelectsCell : UICollectionViewCell
/** 代购平台图片 */
@property (nonatomic,strong) NSArray<NSString*> * platImgs;
/** 点击代购平台回调 */
@property (nonatomic,copy)void(^didSelectPlatImgClickBlock)(NSString*);

@end

@interface YNHotClassesCell : UICollectionViewCell
/** 热门分类图片URLString */
@property (nonatomic,strong) NSArray<NSString*> * imageURLs;
/** 点击热门分类回调 */
@property (nonatomic,copy)void(^didSelectHotClassImgClickBlock)(NSString*);

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
/** 大图 */
@property (nonatomic,weak) UIImageView *bigImageView;
/** 名称 */
@property (nonatomic,weak) UILabel *nameLabel;
/** 型号 */
@property (nonatomic,weak) UILabel *versionLabel;
/** ￥符号 */
@property (nonatomic,weak) UILabel *markLabel;
/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

@end

typedef void(^moreButtonClickBlock)(NSString*);
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
