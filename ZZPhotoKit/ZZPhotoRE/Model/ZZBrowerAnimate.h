//
//  ZZBrowerAnimate.h
//  ZZFramework
//
//  Created by Yuan on 15/12/28.
//  Copyright © 2015年 zzl. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "Common.h"
typedef  NS_ENUM(NSInteger,AnimateStyle){
    PushAnimate,
    ZZBrowerAnimateStyleOfBoxCenter,
    ZZBrowerAnimateStyleOfBoxLeft,
};
@interface ZZBrowerAnimate : NSObject <UIViewControllerAnimatedTransitioning>

@property(assign,nonatomic) AnimateStyle style;

@end
