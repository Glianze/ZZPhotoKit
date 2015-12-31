//
//  ZZUIFactory.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZZUIFactory : NSObject
//推荐页面四个导航按钮
+(UIButton *) createrect:(CGRect) frame createname:(NSString *)btnName action:(SEL) action;
//导航栏 只有文字的按钮
+(UIBarButtonItem *)createFontBtn:(CGRect)frame text:(NSString *)text target:(id) target action:(SEL)action;
//自定义导航栏返回按钮
+(UIBarButtonItem *)createBackButton:(CGRect)frame image:(UIImage *)image target:(id)target action:(SEL)selector;

//首页小工具专用按钮
+(UIButton *) createrect:(CGRect)frame heightImage:(UIImage *)heightimage toolPicture:(UIImage *) toolpicture toolName:(NSString *)toolname action:(SEL)action;
//带边框的按钮
+(UIBarButtonItem *)createRightButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)selector;
//我的资料页面所需label
+(UILabel *)context:(NSString *)context;
//我的资料页面
+(UIView *)viewRect:(CGRect)viewframe  imageRect:(CGRect)imageframe addImage:(NSString *)imageNamed labelText:(NSString *)text;
//新闻页面导航栏文字
+(UILabel *)newsNav:(NSString *)context;
//筛选按钮
+(UIButton *)pullBtnRect:(CGRect)frame pullBtnTitle:(NSString *)title normalImage:(UIImage *)namalImage selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;
//导航栏只有图片得按钮组
+(UIBarButtonItem *)createNavItem:(CGRect)frame image:(UIImage *)image target:(id)target action:(SEL)action;
//生活信息页面菜单列表View
+(UIView *)createMenu:(CGRect)frame topImage:(NSString *)topImage downImage:(NSString *)downImage addCollectionView:(UIView *)view;
//生活信息房产详细页面评论回复数量View
+(UIView *)createValuNum:(CGRect)frame ValuNum:(int) valuNum;
//搜索按钮封装
+(UIBarButtonItem *)createSearchBar:(CGRect)frame target:(id)target action:(SEL)action;

@end
