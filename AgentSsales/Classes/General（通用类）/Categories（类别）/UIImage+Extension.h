//
//  UIImage+Extension.h
//  YiQiGanDianSha2
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YQImageType) {
    YQImageTypePNG = 0,          // regular table view
    YQImageTypeJPG         // preferences style table view
};

@interface UIImage (Extension)

/**
 *  根据指定的图片宽度等比例缩放图片, 文件大小, 返回ImageData
 *
 *  @param defaultWidth     图片宽度
 *  @param maxFileSize      图片最大大小
 *
 */
- (NSData *)adjustImageDataWithDfaultWidth:(CGFloat)defaultWidth maxFileSize:(NSInteger)maxFileSize;

/**  根据指定的图片Size, 文件大小, 压缩图片
 *
 *   @param defaultWidth    图片宽度
 *   @param fileSize        图片最大大小
 *   @param complected      完成回调
 */
- (void)adjustImageDataWithithDfaultWidth:(CGFloat)defaultWidth maxFileSize:(NSInteger)fileSize complected:(void(^)(NSString *encodedImageStr, NSData *imageData))complected;

/**
 *  根据指定的图片Size, 文件大小, 返回ImageData
 *
 *  @param newSize     图片Size
 *  @param maxFileSize 图片最大大小
 *
 */
- (NSData *)adjustImageDataWithNewSize:(CGSize)newSize maxFileSize:(NSInteger)maxFileSize;

/**
 *  根据指定的图片Size, 文件大小, 压缩图片
 *
 *  @param newSize    图片Size
 *  @param fileSize   图片最大大小
 *  @param complected 完成回调
 */
- (void)adjustImageDataWithNewSize:(CGSize)newSize maxFileSize:(NSInteger)fileSize complected:(void(^)(NSString *encodedImageStr, NSData *imageData))complected;


- (UIImage *)adjustShareImageWithithDfaultWidth:(CGFloat)defaultWidth maxFileSize:(NSInteger)fileSize;

/**
 *  Return a full screen image with fileName in content files.
 *
 *  @param fileName image with fileName.
 */
+ (UIImage *)fullScreenImageWithContentName:(NSString *)fileName;

/**
 Return an image with fileName in content files.
 
 @param fileName  image with fileName.
 */
+ (UIImage *)imageWithFileName:(NSString *)fileName;

/**
 Create and return a 1x1 point size image with the given color.
 
 @param color  The color.
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 Create and return a pure color image with the given color and size.
 
 @param color  The color.
 @param size   New image's type.
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;

@end
