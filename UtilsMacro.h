//
//  UtilsMacro.h
//  WProjectForNative
//
//  Created by HuangZhen on 16/9/9.
//  Copyright © 2016年 HuangZhen. All rights reserved.

#ifndef UtilsMacro_h
#define UtilsMacro_h
#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define HZ_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define HZ_NavBarHeight 44.0f
#define NavBarHeight (HZ_StatusBarHeight + HZ_NavBarHeight) //整个导航栏高度
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define KTopHeight (kStatusBarHeight + kNavBarHeight)
#define KTarbarHeight  (kDevice_Is_iPhoneX ? 83 : 49)
#define KTabbarSafeBottomMargin  (kDevice_Is_iPhoneX ? 34 : 0)
#define TABBAR_BOTTOM     (IPHONE_X ? 34.0f : 10.0f)     //标签栏距离底部高度

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define BASE_BLUE_COLOR RGBA(0.35f, 0.68f, 1.0f, 1.0f)
#define DARK_BLUE_COLOR RGBA(0.30, 0.64, 0.91, 1.0f)

#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhoneXDevice ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kRealValue(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)

#define F(string, args...)                  [NSString stringWithFormat:string, args]

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define kBundleIdentifier         [[NSBundle mainBundle] bundleIdentifier]

#define KeyBoardInputAccessoryViewSpec                      (ScreenHeight>480?7.0f:29.0f)

#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"//输入用户名只允许英文、数字、下划线或减号
//常用颜色
#define kMainColor RGB(144,0,255)//主色调
//#define kMainColor RGB(255,87,0)//主色调
#define kSecMainColor RGB(255,128,0)//第二主色调
#define kNavBlueColor RGB(64,158,255)
#define kNavTitleColor RGB(51,51,51)//重要文字
#define kNavInfoTextColor RGB(102,102,102)//用于段落信息提示、普通按钮
#define kNavUnImportTextColor RGB(153,153,153)//用于大面积文字排版、辅助、次要文字信息
#define kNavLineColor RGB(248,248,248)//用于分割线
#define kNavTipsColor RGB(204,204,204)//提示文字
#define kNavTipsBackColor RGB(255,238,230)//提示文字模块底色
#define kNavWhiteColor RGB(255,255,255)
#define kNavBackGround RGB(248,248,248)
//常用的字体类型
#define PingFangSCLight @"PingFangSC-Light"
#define PingFangSCedium @"PingFangSC-Medium"
#define PingFangSCRegular @"PingFangSC-Regular"
#define PingFangSCSemibold @"PingFangSC-Semibold"
#endif /* UtilsMacro_h */
