//
//  ZZDefine.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#ifndef ZZFramework_ZZDefine_h
#define ZZFramework_ZZDefine_h
//NavBar高度
#define NavigationBar_HEIGHT 44

/*-------------------获控制器 高度、宽度--------------------*/
#define VW (self.view.frame.size.width)
#define VH (self.view.frame.size.height)
/*-------------------获控制器 高度、宽度--------------------*/

/*-------------------获控控件 高度、宽度--------------------*/
#define KW (self.frame.size.width)
#define KH (self.frame.size.height)

/*-------------------获控控件 高度、宽度--------------------*/

/*-------------------获取屏幕 宽度、高度--------------------*/
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/*-------------------获取屏幕 宽度、高度--------------------*/



/*----------------------颜色类---------------------------*/
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/*----------------------颜色类---------------------------*/

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]


#define AddBack(backTapped) \
{\
UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];\
UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];\
back.frame = CGRectMake(0, 0, 45, 44);\
[back setBackgroundImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];\
[back setBackgroundImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateHighlighted];\
[back addTarget:self action:@selector(backTopPage) forControlEvents:UIControlEventTouchUpInside];\
[bg addSubview:back];\
UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bg];\
self.navigationItem.leftBarButtonItem = leftItem;\
}
//当没有数据时，其他行隐藏分割线
#define hiddenSepretor(tableView) \
{\
UIView *v = [[UIView alloc] initWithFrame:CGRectZero];\
[tableView setTableFooterView:v];\
}\
//设置满屏分割线 viewdidload中
#define setSepretor(_table) \
{\
if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {\
[_table setSeparatorInset:UIEdgeInsetsZero];\
}\
if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {\
[_table setLayoutMargins:UIEdgeInsetsZero];\
}\
}
//设置满屏分割线 tableView代理方法中
#define setCellSepretor() \
{\
if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {\
[cell setSeparatorInset:UIEdgeInsetsZero];\
}\
if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {\
[cell setLayoutMargins:UIEdgeInsetsZero];\
}\
}


#endif
