//
//  Common.h
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#ifndef Common_h
#define Common_h


/////配置文件/////


/*
 公共文件
 */
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

/*
 控制器
 */
#define ZZ_VW (self.view.frame.size.width)
#define ZZ_VH (self.view.frame.size.height)

#define ZZ_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define ZZ_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/*
 颜色
 */
#define ZZ_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ZZ_RGB(r,g,b) ZZ_RGBA(r,g,b,1.0f)

/*
 图片
 */

//   相册列表页面右边箭头图片
#define PhotoListRightBtn      [UIImage imageNamed:@"zz_alumb_rightCell.png"]
//   相册列表页面，当没有数据时使用图片
#define NOPhoto_Data_Pic       [UIImage imageNamed:@"no_data.png"]
//   图片选中状态图片
#define Pic_Btn_Selected       [UIImage imageNamed:@"select_yes.png"]
//   图片未选中状态图片
#define Pic_btn_UnSelected     [UIImage imageNamed:@"select_no.png"]
//   拍照图片
#define TakePhoto_Btn_Pic      [UIImage imageNamed:@"take_photo_pic.png"]
//   闪光灯按钮图片
#define Flash_Open_Btn_Pic     [UIImage imageNamed:@"flash_open_pic.png"]
#define Flash_close_Btn_Pic    [UIImage imageNamed:@"flash_close_pic.png"]
//   切换前置后置摄像头按钮
#define Change_Btn_Pic         [UIImage imageNamed:@"change_camera_pic.png"]
//   删除图片按钮
#define Remove_Btn_Pic         [UIImage imageNamed:@"remove_btn_pic.png"]

/*
 文字
 */
//   相册详细页面底部Footer显示文字
#define Total_Pic_Num @"%ld 张照片"
#define Alert_Max_Selected @"最多只能选择%ld张图片"
#define Alert_Max_TakePhoto @"最多连拍张数为%ld张图片"
#endif /* Common_h */
