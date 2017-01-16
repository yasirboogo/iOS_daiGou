//
//  PDVersionTool.m
//  Yios
//
//  Created by 潘东 on 15/10/25.
//  Copyright (c) 2015年 Dream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDVersionTool : NSObject

/*
 * 保存版本信息到沙盒（用户偏好设置）
 */
+(void)saveVersionToSandbox;

+(BOOL)isFirstUseApp;

+(BOOL)isNewVersion;

+(BOOL)needShowNewFeature;

@end
