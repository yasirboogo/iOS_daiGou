//
//  SystemMacro.h
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#ifndef SystemMacro_h
#define SystemMacro_h

#endif /* SystemMacro_h */

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kUITabBarH        49.0f
#define kUIStatusBar    20.0f
#define kUINavHeight    (44.0f+20.0f)
#define kUINavBtnHorSpace  8.0f
#define kUINavBtnVerSpace  7.0f
#define kUINavBtnWidth  30.0f
#define SCREEN_POINT (float)SCREEN_WIDTH/750.0f
#define SCREEN_H_POINT (float)SCREEN_HEIGHT/1136.0f

#define W_RATIO(w) w*SCREEN_WIDTH/750.0
//颜色
#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kColorAlpha(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
// View 坐标(x,y)和宽高(width,height)
#define XF(v)               (v).frame.origin.x
#define YF(v)               (v).frame.origin.y
#define WIDTHF(v)           (v).frame.size.width
#define HEIGHTF(v)          (v).frame.size.height

#define MinXF(v)            CGRectGetMinX((v).frame)
#define MinYF(v)            CGRectGetMinY((v).frame)

#define MidXF(v)            CGRectGetMidX((v).frame)
#define MidYF(v)            CGRectGetMidY((v).frame)

#define MaxXF(v)            CGRectGetMaxX((v).frame)
#define MaxYF(v)            CGRectGetMaxY((v).frame)

// Frame 坐标(x,y)和宽高(width,height)
#define X(v)               (v).origin.x
#define Y(v)               (v).origin.y
#define WIDTH(v)           (v).size.width
#define HEIGHT(v)          (v).size.height

#define MinX(v)            CGRectGetMinX(v)
#define MinY(v)            CGRectGetMinY(v)

#define MidX(v)            CGRectGetMidX(v)
#define MidY(v)            CGRectGetMidY(v)

#define MaxX(v)            CGRectGetMaxX(v)
#define MaxY(v)            CGRectGetMaxY(v)

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone_3_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S/SE 分辨率320x568，像素640x1136，@2x */
#define iPhone_4_0 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6/6s/7/7s 分辨率375x667，像素750x1334，@2x */
#define iPhone_4_7 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6Plus/7Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone_5_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif
//----------------------ABOUT SYSTYM & VERSION 系统与版本
/** 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define isiPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 系统版本 */
#define isLaterVerison(__VERSION__) (([[[UIDevice currentDevice] systemVersion] floatValue] >= __VERSION__)? (YES):(NO))

/** 获取当前语言 */
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取Verison号
#define IOS_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

//获取build号
#define IOS_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/** 是否为iOS6 */
#define iOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) ? YES : NO)

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)

/** 是否为iOS10 */
#define iOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)

//----------------------ABOUT PRINTING LOG 打印日志 ----------------------------
//状态下打印日志
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//调试模式下打印日志,当前行并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif

/** print 打印rect,size,point */
#ifdef DEBUG
#define kPrintPoint(point)    NSLog(@"%s = { x:%.4f, y:%.4f }", #point, point.x, point.y)
#define kPrintSize(size)      NSLog(@"%s = { w:%.4f, h:%.4f }", #size, size.width, size.height)
#define kPrintRect(rect)      NSLog(@"%s = { x:%.4f, y:%.4f, w:%.4f, h:%.4f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#endif


//----------------------ABOUT IMAGE 图片 ----------------------------
//读取本地图片
#define IMAGEWITHPATH(__FILE__,__TYPE__) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:__FILE__ ofType:__TYPE__]]

//定义UIImage对象
#define IMAGEWITHNAME(__NAME__) [UIImage imageNamed:__NAME__]

//沙盒路径
#define HOMEPATH(___NAME_) [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:__NAME__];

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

/**
 *  the saving objects      存储对象
 */
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define PLIST_TICKET_INFO_EDIT [NSHomeDirectory() stringByAppendingString:@"/Documents/data.plist"] //edit the plist

#define TableViewCellDequeueInit(__INDETIFIER__) [tableView dequeueReusableCellWithIdentifier:(__INDETIFIER__)];

#define TableViewCellDequeue(__CELL__,__CELLCLASS__,__INDETIFIER__) \
{\
if (__CELL__ == nil) {\
__CELL__ = [[__CELLCLASS__ alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:__INDETIFIER__];\
}\
}

#define CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]

//Show Alert, brackets is the parameters.       宏定义一个弹窗方法,括号里面是方法的参数
#define ShowAlert    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning." message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: @"OK"];[alert show];

// 自身弱引用
#define WEAK_SELF()  __weak __typeof(self) weakSelf = self

//单例化 一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#define DEFAULTS  [NSUserDefaults standardUserDefaults]

#define kUserLoginInfors  @"userLoginInfors"

#define kKeychainService  @"com.daiGou"
