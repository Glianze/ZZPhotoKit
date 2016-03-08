//
//  ZZPhotoAnimation.h
//  ZZPhotoKit
//
//  Created by Yuan on 16/3/8.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
@interface ZZPhotoAnimation : NSObject

+(ZZPhotoAnimation *)sharedAnimation;

-(void) roundAnimation:(UILabel *)label;

-(void) selectAnimation:(UIButton *)button;
@end
