//
//  PicsCell.m
//  ZZPhotoKit
//
//  Created by Yuan on 16/1/13.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "PicsCell.h"

@implementation PicsCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 50) / 3;
        
        _photo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, photoSize, photoSize)];
        
        _photo.layer.masksToBounds = YES;
        
        _photo.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_photo];
    }
    return self;
}

@end
