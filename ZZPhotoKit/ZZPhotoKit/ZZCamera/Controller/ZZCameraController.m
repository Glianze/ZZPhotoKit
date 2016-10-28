//
//  ZZCameraController.m
//  ZZFramework
//
//  Created by Yuan on 15/12/18.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZCameraController.h"
#import "ZZCameraPickerViewController.h"
@interface ZZCameraController()

@property (strong,nonatomic) ZZCameraPickerViewController *cameraPickerController;

@end

@implementation ZZCameraController

-(ZZCameraPickerViewController *)cameraPickerController
{
    if (!_cameraPickerController) {
        _cameraPickerController = [[ZZCameraPickerViewController alloc]init];
    }
    return _cameraPickerController;
}

-(void)showIn:(UIViewController *)controller result:(ZZCameraResult)result
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusNotDetermined) {
        //相机进行授权
        /* * * 第一次安装应用时直接进行这个判断进行授权 * * */
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showController:controller result:result];
                });
            }
        }];
    }else if (status == AVAuthorizationStatusAuthorized){
        [self showController:controller result:result];
    }else if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied){
        [self showAlertViewToController:controller];
    }
}

-(void)showController:(UIViewController *)controller result:(ZZCameraResult)result
{
    self.cameraPickerController.CameraResult    = result;
    //设置连拍最大张数
    self.cameraPickerController.takePhotoOfMax  = self.takePhotoOfMax;
    //设置返回图片类型
    self.cameraPickerController.isSavelocal     = self.isSaveLocal;
    self.cameraPickerController.themeColor      = self.themeColor;
    [controller presentViewController:self.cameraPickerController animated:YES completion:nil];
}

-(void)showAlertViewToController:(UIViewController *)controller
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"请在iPhone的“设置->隐私->照片”开启%@访问你的相机",app_Name] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:action1];
    [controller presentViewController:alert animated:YES completion:nil];
}

@end
