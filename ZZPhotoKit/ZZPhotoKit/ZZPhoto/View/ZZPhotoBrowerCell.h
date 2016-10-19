//
//  ZZPhotoBrowerCell.h
//  ZZPhotoKit
//
//  Created by 袁亮 on 16/10/19.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"

@interface ZZPhotoBrowerCell : UICollectionViewCell

-(void)loadPHAssetItemForPics:(PHAsset *)assetItem;

-(void)recoverSubview;

@end
