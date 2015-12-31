//
//  ZZCustomHUD.m
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ZZCustomHUD.h"

@implementation ZZCustomHUD


+(ZZCustomHUD *)hudAlertView
{
    static ZZCustomHUD *hud;
    if (hud == nil) {
        @synchronized (self){
            hud = [[ZZCustomHUD alloc]init];
            assert(hud != nil);
        }
    }
    return hud;
}

-(void)showAlertViewTo:(UIView *) view message:(NSString *)message
{
    UILabel *alertlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    
    alertlabel.textColor = [UIColor whiteColor];
    
    [alertlabel setNumberOfLines:0];
    
    NSString *alertText = message;
    
    alertlabel.text = alertText;
    
    alertlabel.textAlignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    
    alertlabel.font = font;
    
    CGSize labelsize = [alertText sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    
    [alertlabel setFrame:CGRectMake(8, 8, labelsize.width, labelsize.height)];
    
    CGFloat view1x = SCREEN_WIDTH / 2 - (alertlabel.width / 2) - 8;
    
    UIView * alertView = [[UIView alloc]initWithFrame:CGRectMake(view1x, SCREEN_HEIGHT - SCREEN_HEIGHT / 3, labelsize.width + 16, labelsize.height +16)];
    
    alertView.backgroundColor = [UIColor blackColor];
    
    alertView.alpha = 0.7;
    
    alertView.layer.masksToBounds = YES;
    
    alertView.layer.cornerRadius = 4;
    
    [alertView addSubview:alertlabel];
    
    [view addSubview:alertView];
    
    [UIView animateWithDuration:5.0f
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         alertView.alpha = 0;
                         
                     }
                     completion:^(BOOL finished){
                         if(alertView.alpha == 0) {
                             
                             [[NSNotificationCenter defaultCenter] removeObserver:alertView];
                             [[UIApplication sharedApplication].windows.lastObject makeKeyAndVisible];
                             
                         }
                     }];
    
}

@end
