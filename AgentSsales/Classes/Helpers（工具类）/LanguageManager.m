//
//  LanguageManager.m
//  AgentSsales
//
//  Created by innofive on 16/12/21.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "LanguageManager.h"
#import "AppDelegate.h"
#import "YNTabBarController.h"
#import "YNLoginViewController.h"

#define NSLocalizedStringTableName @"Localizable"
#define UserLanguage @"userLanguage"

@interface LanguageManager ()

@property (nonatomic,strong) NSBundle *bundle;

@end

@implementation LanguageManager

+ (instancetype)shareInstance {
    static LanguageManager *_manager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

//初始化语言
- (void)initUserLanguage {
    
    NSString *currentLanguage = [LanguageManager currentLanguage];
    
    if(currentLanguage.length == 0){
        
        //获取系统偏好语言数组
        NSArray *languages = [NSLocale preferredLanguages];
        //第一个为当前语言
        currentLanguage = [languages objectAtIndex:0];
        
        [self saveLanguage:currentLanguage];
    }
    
    [self changeBundle:currentLanguage];
}

//语言和语言对应的.lproj的文件夹前缀不一致时在这里做处理
- (NSString *)languageFormat:(NSString*)language {
    if([language rangeOfString:@"zh-Hans"].location != NSNotFound)
    {
        return @"zh-Hans";
    }
    else if([language rangeOfString:@"zh-Hant"].location != NSNotFound)
    {
        return @"zh-Hant";
    }
    else
    {
        //字符串查找
        if([language rangeOfString:@"-"].location != NSNotFound) {
            //除了中文以外的其他语言统一处理@"ru_RU" @"ko_KR"取前面一部分
            NSArray *ary = [language componentsSeparatedByString:@"-"];
            if (ary.count > 1) {
                NSString *str = ary[0];
                return str;
            }
        }
    }
    return language;
}

//设置语言
-(void)setUserlanguage:(NSInteger)languageIndex type:(NSInteger)type{
    NSArray *language = @[@"zh-Hans",@"ms-my",@"en-us"];
    if (![[LanguageManager currentLanguage] isEqualToString:language[languageIndex]]) {
        [self saveLanguage:language[languageIndex]];
        
        [self changeBundle:language[languageIndex]];
        
        [self resetRootViewControllerWithType:type];
        
    }
}

//改变bundle
- (void)changeBundle:(NSString *)language {
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:language] ofType:@"lproj" ];
    _bundle = [NSBundle bundleWithPath:path];
}

//保存语言
- (void)saveLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:language forKey:UserLanguage];
    [defaults synchronize];
}
//重新设置
-(void)resetRootViewControllerWithType:(NSInteger)type{
    AppDelegate *appDelegate =
    (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (type == 0) {
        YNTabBarController *tabBC = [[YNTabBarController alloc]init];
        appDelegate.window.rootViewController = tabBC;
    }else if (type == 1){
        YNLoginViewController *linVC = [[YNLoginViewController alloc]init];
        appDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:linVC];
    }
}
//获取语言
+ (NSString *)currentLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *language = [defaults objectForKey:UserLanguage];
    return language;
}
+(NSInteger)currentLanguageIndex{
    
    NSArray *language = @[@"zh-Hans",@"ms-my",@"en-us"];
    
    NSString *currentLanguage = [LanguageManager currentLanguage];
    if (currentLanguage.length == 0) {
        currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];;
    }
    for (NSInteger index = 0; index < language.count; index ++) {
        if ([language[index] hasPrefix:currentLanguage]) {
            return index;
        }
    }
    return 0;
}
//获取当前语种下的内容
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value {
    if (!_bundle) {
        [self initUserLanguage];
    }
    
    if (key.length > 0) {
        if (_bundle) {
            NSString *str = NSLocalizedStringFromTableInBundle(key, NSLocalizedStringTableName, _bundle, value);
            if (str.length > 0) {
                return str;
            }
        }
    }
    return @"";
}

//图片多语言处理 有2种处理方案，第一种就是和文字一样，根据语言或者对应路径下的图片文件夹，然后用获取文字的方式，获取图片名字，或者用下面这种方法，图片命名的时候加上语言后缀，获取的时候调用此方法，在图片名后面加上语言后缀来显示图片
- (UIImage *)ittemInternationalImageWithName:(NSString *)name {
    NSString *selectedLanguage = [self languageFormat:[LanguageManager currentLanguage]];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",name,selectedLanguage]];
    return image;
}


@end
