//
//  ZZPhotoPickerFooterView.m
//  ZZPhotoKit
//
//  Created by 袁亮 on 16/10/12.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ZZPhotoPickerFooterView.h"
#import "ZZResourceConfig.h"

@interface ZZPhotoPickerFooterView()

@property (nonatomic, strong) UILabel *totalNumLabel;

@end

@implementation ZZPhotoPickerFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeFooterViewUI];
        
    }
    return self;
}

-(void) makeFooterViewUI
{
    _totalNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _totalNumLabel.textColor = [UIColor blackColor];
    _totalNumLabel.textAlignment = NSTextAlignmentCenter;
    _totalNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_totalNumLabel];
    
    NSLayoutConstraint *total_label_left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_totalNumLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *total_label_right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_totalNumLabel attribute:NSLayoutAttributeRight multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *total_label_top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_totalNumLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *total_label_bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_totalNumLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f];
    
    
    [self addConstraints:@[total_label_left,total_label_right,total_label_top,total_label_bottom]];
    
}

-(void)setTotal_photo_num:(NSInteger)total_photo_num
{
    _totalNumLabel.text = [NSString stringWithFormat:Total_Photo_Num,total_photo_num];
}


@end
