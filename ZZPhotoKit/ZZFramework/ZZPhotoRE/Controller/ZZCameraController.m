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
    cameraPickerController.takePhotoOfMax = self.takePhotoOfMax;
    [controller presentViewController:cameraPickerController animated:YES completion:nil];
}

@end
