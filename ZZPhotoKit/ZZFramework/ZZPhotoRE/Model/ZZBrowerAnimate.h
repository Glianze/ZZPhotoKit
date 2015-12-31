//
//  ZZBrowerAnimate.h
//  ZZFramework
//
//  Created by Yuan on 15/12/28.
//  Copyright © 2015年 zzl. All rights reserved.
//

typedef  NS_ENUM(NSInteger,AnimateStyle){
    PushAnimate,
    ZZBrowerAnimateStyleOfBoxCenter,
    ZZBrowerAnimateStyleOfBoxLeft,
};

#import <Foundation/Foundation.h>

@interface ZZBrowerAnimate : NSObject <UIViewControllerAnimatedTransitioning>

@property(assign,nonatomic) AnimateStyle style;

@end
