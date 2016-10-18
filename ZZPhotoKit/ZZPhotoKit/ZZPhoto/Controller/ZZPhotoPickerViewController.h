//
//  ZZPhotoPickerViewController.h
//  ZZFramework
//
//  Created by Yuan on 15/7/7.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"


@interface ZZPhotoPickerViewController : UIViewController

@property (nonatomic,   copy) void (^PhotoResult)(id responseObject);
@property (nonatomic, assign) BOOL            isAlubSeclect;
@property (nonatomic, strong) UIColor         *roundColor;
@property (nonatomic, assign) NSInteger       selectNum;
@property (nonatomic, strong) PHFetchResult   *fetch;

@end
