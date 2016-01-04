//
//  ZZCameraController.m
//  ZZFramework
//
//  Created by Yuan on 15/12/18.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZCameraController.h"
#import "ZZCameraPickerViewController.h"
@implementation ZZCameraController

-(void)showIn:(UIViewController *)controller result:(ZZCameraResult)result
{
    ZZCameraPickerViewController *cameraPickerController = [[ZZCameraPickerViewController alloc]init];
    
    cameraPickerController.CameraResult = result;
    //设置连拍最大张数
    cameraPickerController.takePhotoOfMax = self.takePhotoOfMax;
    //设置返回图片类型
    cameraPickerController.imageType = self.imageType;
    [controller presentViewController:cameraPickerController animated:YES completion:nil];
}

@end
