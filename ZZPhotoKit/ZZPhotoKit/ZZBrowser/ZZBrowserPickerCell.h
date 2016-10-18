//
//  ZZBrowserPickerCell.h
//  ZZFramework
//
//  Created by Yuan on 15/12/23.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"

@protocol ZZBrowserPickerCellDelegate <NSObject>

-(void) clickZoomView;

@end

@interface ZZBrowserPickerCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *pics;

@property (nonatomic, weak)   id<ZZBrowserPickerCellDelegate>delegate;

-(void)loadPHAssetItemForPics:(PHAsset *)assetItem;

@end
