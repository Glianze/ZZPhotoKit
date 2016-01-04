//
//  ZZBrowserPickerCell.m
//  ZZFramework
//
//  Created by Yuan on 15/12/23.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZBrowserPickerCell.h"

@implementation ZZBrowserPickerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pics = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _pics.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_pics];
    }
    return self;
}

-(void)loadPHAssetItemForPics:(PHAsset *)assetItem
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
    options.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:assetItem
                                               targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                
                                                self.pics.image = result;
                                                
                                            }];
}
@end
