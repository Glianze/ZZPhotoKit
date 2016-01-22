//
//  ZZCameraFlashState.m
//  ZZPhotoKit
//
//  Created by Yuan on 16/1/22.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ZZCameraFlashState.h"

@implementation ZZCameraFlashState

+(ZZCameraFlashState *)flashState
{
    static ZZCameraFlashState *flashState = nil;
    if (flashState == nil) {
        flashState = [[ZZCameraFlashState alloc]init];
    }
    return flashState;
}



//设置闪光灯的默认状态

-(BOOL)flashLightState
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * value = [setting objectForKey:@"State"];
    if (value && [value isEqualToString:@"1"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)isOpen:(BOOL)isState
{
    NSUserDefaults *state = [NSUserDefaults standardUserDefaults];
    [state setObject:isState ? @"1" : @"0" forKey:@"State"];
    [state synchronize];
}

@end
