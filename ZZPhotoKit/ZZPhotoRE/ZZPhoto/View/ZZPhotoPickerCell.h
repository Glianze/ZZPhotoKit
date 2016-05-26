//
//  ZZPhotoPickerCell.h
//  ZZFramework
//
//  Created by Yuan on 15/7/7.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"
#import "ZZPhoto.h"
@interface ZZPhotoPickerCell : UICollectionViewCell

@property(strong,nonatomic) UIImageView *photo;
@property(strong,nonatomic) UIButton *selectBtn;


-(void)loadPhotoData:(ZZPhoto *)assetItem;
-(void)selectBtnStage:(NSMutableArray *)selectArray existence:(ZZPhoto *)photo;
@end
