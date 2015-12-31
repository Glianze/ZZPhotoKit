//
//  ZZCustomHUD.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCustomHUD : NSObject

+(ZZCustomHUD *)hudAlertView;

-(void)showAlertViewTo:(UIView *) view message:(NSString *)message;

@end
