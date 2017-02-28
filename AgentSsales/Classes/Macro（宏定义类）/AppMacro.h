//
//  AppMacro.h
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

/** 主色调 */
#define COLOR_DF463E kColorFromRGB(0xDF463E)
/** 辅色调 */
#define COLOR_649CE0 kColorFromRGB(0x649CE0)
#define COLOR_69B6FF kColorFromRGB(0x69B6FF)
#define COLOR_B7B7B7 kColorFromRGB(0xB7B7B7)
#define COLOR_5A5A5A kColorFromRGB(0x5A5A5A)
#define COLOR_EF697B kColorFromRGB(0xEF697B)
#define COLOR_EEEEEE kColorFromRGB(0xEEEEEE)
#define COLOR_F6D3D2 kColorFromRGB(0xF6D3D2)
#define COLOR_2B363C kColorFromRGB(0x2B363C)
#define COLOR_CECECE kColorFromRGB(0xCECECE)
#define COLOR_A4A4A4 kColorFromRGB(0xA4A4A4)
#define COLOR_BABABA kColorFromRGB(0xBABABA)
#define COLOR_BFBFBF kColorFromRGB(0xBFBFBF)
#define COLOR_FFF6E0 kColorFromRGB(0xFFF6E0)
#define COLOR_929292 kColorFromRGB(0x929292)
#define COLOR_328FFF kColorFromRGB(0x328FFF)
/** 背景色 */
#define COLOR_EDEDED kColorFromRGB(0xEDEDED)
/** 阴影 */
#define COLOR_7A1611 kColorFromRGB(0x7A1611)
/** 分割色 */
#define COLOR_E9E9E9 kColorFromRGB(0xE9E9E9)
/** 仅用于【我的】页面小图标 */
#define COLOR_4669FF kColorFromRGB(0x4669FF)
/** 一级文字色 */
#define COLOR_333333 kColorFromRGB(0x333333)
/** 二级文字色 */
#define COLOR_666666 kColorFromRGB(0x666666)
/** 三级文字色 */
#define COLOR_999999 kColorFromRGB(0x999999)
/** 四级文字色 */
#define COLOR_FF4844 kColorFromRGB(0xFF4844)
/** 白色 */
#define COLOR_FFFFFF kColorFromRGB(0xFFFFFF)
/** 黑色 */
#define COLOR_000000 kColorFromRGB(0x000000)
/** 透明色 */
#define COLOR_CLEAR [UIColor clearColor]

#define FONT_18 [UIFont systemFontOfSize:18.0]
#define FONT_17 [UIFont systemFontOfSize:17.0]
#define FONT_16 [UIFont systemFontOfSize:16.0]
#define FONT_15 [UIFont systemFontOfSize:15.0]
#define FONT_14 [UIFont systemFontOfSize:14.0]
#define FONT_13 [UIFont systemFontOfSize:13.0]
#define FONT_12 [UIFont systemFontOfSize:12.0]
#define FONT_11 [UIFont systemFontOfSize:11.0]
#define FONT_10 [UIFont systemFontOfSize:10.0]

#define FONT(x) [UIFont systemFontOfSize:W_RATIO(x)]


/** 圆角 */
#define kViewRadius W_RATIO(10)
/** 描边 */
#define kOutLine W_RATIO(2)
/** 大边距 */
#define kMaxSpace W_RATIO(60)
/** 中边距 */
#define kMidSpace W_RATIO(40)
/** 小边距 */
#define kMinSpace W_RATIO(10)
/** 0边距 */
#define kZero W_RATIO(0.001)

#define kZeroStr @"0"

#endif /* AppMacro_h */
