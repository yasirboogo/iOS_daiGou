//
//  UIImage+Extension.m
//  YiQiGanDianSha2
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 CH. All rights reserved.
//

#import "UIImage+Extension.h"

typedef NS_ENUM(NSInteger, ImageType) {
    ImageTypeJPEG,          // regular table view
    ImageTypePNG         // preferences style table view
};

@implementation UIImage (Extension)

- (NSData *)adjustImageDataWithNewSize:(CGSize)newSize maxFileSize:(NSInteger)maxFileSize
{
    // ImageSize
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // FileSize
    CGFloat compression = 1.0f;
    CGFloat minCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(newImage, compression);
#warning 可算法优化(二分树+多线程)
    while ([imageData length] > maxFileSize && compression > minCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    
    return imageData;
}

- (void)adjustImageDataWithNewSize:(CGSize)newSize maxFileSize:(NSInteger)fileSize complected:(void(^)(NSString *encodedImageStr, NSData *imageData))complected
{
        dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        // 压缩图片
#warning 调节ImageSize
        NSData *imageData = [self adjustImageDataWithNewSize:newSize maxFileSize:fileSize];
        
        dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            // Data -> Base64
            NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complected)
                {
                    complected(encodedImageStr, imageData);
                }
            });
        });
    });
}

- (NSData *)adjustImageDataWithDfaultWidth:(CGFloat)defaultWidth maxFileSize:(NSInteger)maxFileSize
{
    // Covert ImageSize
    CGFloat originalWidth = self.size.width;
    CGFloat originalHeight = self.size.height;
    CGFloat targetWidth = defaultWidth;
    CGFloat targetHeight = (targetWidth / originalWidth) * originalHeight;
    // ImageSize
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // FileSize
    CGFloat compression = 1.0f;
    CGFloat minCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(newImage, compression);
#warning 可算法优化(二分树+多线程)
    while ([imageData length] > maxFileSize && compression > minCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    
    return imageData;
}

- (void)adjustImageDataWithithDfaultWidth:(CGFloat)defaultWidth maxFileSize:(NSInteger)fileSize complected:(void(^)(NSString *encodedImageStr, NSData *imageData))complected
{
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        // 压缩图片
        NSData *imageData = [self adjustImageDataWithDfaultWidth:defaultWidth maxFileSize:fileSize];
        
        dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            // Data -> Base64
            NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complected)
                {
                    complected(encodedImageStr, imageData);
                }
            });
        });
    });
}

- (UIImage *)adjustShareImageWithithDfaultWidth:(CGFloat)defaultWidth maxFileSize:(NSInteger)fileSize
{
    // Covert ImageSize
    CGFloat originalWidth = self.size.width;
    CGFloat originalHeight = self.size.height;
    CGFloat targetWidth = defaultWidth;
    CGFloat targetHeight = (targetWidth / originalWidth) * originalHeight;
    // ImageSize
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0,0,targetWidth,targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imagePNGData = UIImagePNGRepresentation(newImage);
    if ([imagePNGData length] <= fileSize)
    {
        return newImage;
    }
    
    // FileSize
    CGFloat compression = 1.0f;
    CGFloat minCompression = 0.1f;
    NSData *imageJPEGData = UIImageJPEGRepresentation(newImage, compression);
    
    while ([imageJPEGData length] > fileSize && compression > minCompression && [imagePNGData length] > fileSize)
    {
        compression -= 0.1;
        imageJPEGData = UIImageJPEGRepresentation(newImage, compression);
        newImage = [UIImage imageWithData:imageJPEGData];
        imagePNGData = UIImagePNGRepresentation(newImage);
    }

    return [UIImage imageWithData:imagePNGData];
}

+ (UIImage *)imageWithFileName:(NSString *)fileName
{
    NSString *type = @"png";
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type inDirectory:nil];
    
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)fullScreenImageWithContentName:(NSString *)fileName
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (screenHeight > 668.f) // Plus
    {
        fileName = [fileName stringByAppendingString:@"-736h"];
    }
    else if (screenHeight > 569.f) // 6
    {
        fileName = [fileName stringByAppendingString:@"-667h"];
    }
    else if (screenHeight > 481.f) // 5
    {
        fileName = [fileName stringByAppendingString:@"-568h"];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png" inDirectory:nil];
    
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

//+ (void)squareImageWithOriginalImage:(UIImage *)image squareWidth:(CGFloat)width maxFileSize:(NSInteger)maxFileSize
//{
//    CGFloat imageWidth = image.size.width;
//    CGFloat imageHeight = image.size.height;
    
//    CGFloat targetWidth = width;
//    CGFloat targetHeight = width;
    
    // 不规则图片 -> 正方形
//    if (imageWidth > imageHeight)
//    {
////        UIGraphicsBeginImageContext(newSize);
//    }
//        
//    if (imageWidth < imageHeight)
//    {
//        
//    }

    
//    if (originalImage.size.width == originalImage.size.height && originalImage.size.width == width);
    
    
//}

//- (UIImage *)clipedImage

@end
