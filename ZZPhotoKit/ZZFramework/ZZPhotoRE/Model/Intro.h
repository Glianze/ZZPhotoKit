//
//  Intro.h
//  ZZFramework
//
//  Created by Yuan on 15/12/31.
//  Copyright © 2015年 zzl. All rights reserved.
//

#ifndef Intro_h
#define Intro_h


/* 说明 */

/*
 
    ** 此开源仅供初学者学习参考，不喜欢的大神们还望轻虐。
 
    ** 此开源中并不完善还需以后的慢慢改进，增强功能。
 
    ** 此开源中相机调用部分代码来自另外一个作者。
 
    ** 相册多选使用最新的 PhotoKit 框架
 
    ** 图片浏览器支持 SDWebImage 加载图片
 
    ***
    有什么不明白的地方，或者哪里需要改进的可以联系我 
    
    ** 联系方式
 
    *** 关注微博：袁亮_TRICK  *** QQ:412016060
 
 */

/*
    ** 使用方法
 
    * 相册多选的调用
    ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
 
    //设置最大选择张数
    photoController.selectPhotoOfMax = 5;
 
    [photoController showIn:self result:^(id responseObject){
        //返回结果集
        NSLog(@"%@",responseObject);
        NSArray *array = (NSArray *)responseObject;
 
        UIImage *image = [array objectAtIndex:0];
        _imageView.image = image;
    }];
 
    * 相机连拍的调用
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    //设置最大连拍张数
    cameraController.takePhotoOfMax = 8;
    [cameraController showIn:self result:^(id responseObject){
        //返回结果集
        NSLog(@"%@",responseObject);
        NSArray *array = (NSArray *)responseObject;
 
        UIImage *image = [array objectAtIndex:0];
        _imageView.image = image;
    }];
 
    * 简单的图片浏览器
    ZZBrowserPickerViewController *browserController = [[ZZBrowserPickerViewController alloc]init];
    browserController.delegate = self;
    [browserController showIn:self animation:ShowAnimationOfPush];
    
    //delegate
    //图片的个数。
    -(NSInteger)zzbrowserPickerPhotoNum:(ZZBrowserPickerViewController *)controller
    //图片的数组。
    -(NSArray *)zzbrowserPickerPhotoContent:(ZZBrowserPickerViewController *)controller
 
 
    ** 详细使用方法还是看demo 吧。
 */



#endif /* Intro_h */
