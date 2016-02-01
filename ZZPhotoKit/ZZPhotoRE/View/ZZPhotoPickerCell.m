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
        
        _photo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, photoSize, photoSize)];
        
        _photo.layer.masksToBounds = YES;
        
        _photo.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_photo];
        
        
        CGFloat picViewSize = ([UIScreen mainScreen].bounds.size.width - 3) / 4;
        
        CGFloat btnSize = picViewSize / 4;
        
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(picViewSize - btnSize - 5, 5, btnSize, btnSize)];
        
        [self.contentView addSubview:_selectBtn];
        
    }
    return self;
}

-(void)selectBtnStage:(NSMutableArray *)selectArray existence:(PHAsset *)assetItem
{
    if ([selectArray containsObject:assetItem]) {
        [_selectBtn setImage:Pic_Btn_Selected forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:Pic_btn_UnSelected forState:UIControlStateNormal];
    }
}

-(void)loadPhotoData:(PHAsset *)assetItem
{
    if ([assetItem isKindOfClass:[PHAsset class]]) {
        
        
        PHAsset *phAsset = assetItem;
        
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage *result, NSDictionary *info){
            
            self.photo.image = result;
            
        }];
        
    }
}
@end
