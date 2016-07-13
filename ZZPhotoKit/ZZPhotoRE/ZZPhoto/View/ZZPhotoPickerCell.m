//
//  ZZPhotoPickerCell.m
//  ZZFramework
//
//  Created by Yuan on 15/7/7.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ZZPhotoPickerCell.h"

@implementation ZZPhotoPickerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 3) / 4;
        
        _photo = [[UIImageView alloc]initWithFrame:self.bounds];
        
        _photo.layer.masksToBounds = YES;
        
        _photo.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_photo];
        
        
        CGFloat btnSize = self.frame.size.width / 4;
        
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - btnSize - 5, 5, btnSize, btnSize)];
        
        [self.contentView addSubview:_selectBtn];
        
    }
    return self;
}

//记录按钮选中和非选中的状态
-(void)selectBtnStage:(NSMutableArray *)selectArray existence:(ZZPhoto *)photo
{
    if ([selectArray containsObject:photo]) {
        _selectBtn.selected = YES;
        [_selectBtn setImage:Pic_Btn_Selected forState:UIControlStateNormal];
    }else{
        _selectBtn.selected = NO;
        [_selectBtn setImage:Pic_btn_UnSelected forState:UIControlStateNormal];
    }
}

-(void)loadPhotoData:(ZZPhoto *)assetItem
{
    if ([assetItem isKindOfClass:[ZZPhoto class]]) {

        [[PHImageManager defaultManager] requestImageForAsset:assetItem.asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage *result, NSDictionary *info){
            self.photo.image = result;
            
        }];
        
    }
}
@end
