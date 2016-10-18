//
//  ZZPhotoListViewController.h
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"
@interface ZZPhotoListViewController : UIViewController

@property (nonatomic, assign) NSInteger selectNum;
@property (nonatomic,   copy) void (^photoResult)(id responseObject);

@end
