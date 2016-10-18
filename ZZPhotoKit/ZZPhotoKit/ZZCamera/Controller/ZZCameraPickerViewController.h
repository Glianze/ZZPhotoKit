//
//  ZZCameraPickerViewController.h
//  ZZFramework
//
//  Created by Yuan on 15/12/18.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"

@interface ZZCameraPickerViewController : UIViewController

@property (nonatomic, assign) BOOL isSavelocal;

@property (nonatomic, assign) NSInteger takePhotoOfMax;

@property (nonatomic, strong) UIColor *themeColor;

@property (nonatomic,   copy) void (^CameraResult)(id responseObject);

@end
