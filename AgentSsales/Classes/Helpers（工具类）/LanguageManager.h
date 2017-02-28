//
//  LanguageManager.h
//  AgentSsales
//
//  Created by innofive on 16/12/21.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kLocalizedString(key, comment) [kLanguageManager localizedStringForKey:key value:comment]

@interface LanguageManager : NSObject

@property (nonatomic,copy) void (^completion)(NSString *currentLanguage);

+ (NSString *)currentLanguage; //当前语言
+ (NSInteger)currentLanguageIndex; //当前语言
- (NSString *)languageFormat:(NSString*)language; //语言前缀异常处理
-(void)setUserlanguage:(NSInteger)languageIndex type:(NSInteger)type;//设置当前语言

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

- (UIImage *)ittemInternationalImageWithName:(NSString *)name;

+ (instancetype)shareInstance;

#define kLanguageManager [LanguageManager shareInstance]

@end
