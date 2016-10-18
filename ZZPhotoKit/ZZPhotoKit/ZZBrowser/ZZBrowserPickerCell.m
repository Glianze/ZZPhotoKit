//
//  ZZBrowserPickerCell.m
//  ZZFramework
//
//  Created by Yuan on 15/12/23.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZBrowserPickerCell.h"

@interface ZZBrowserPickerCell()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    CGFloat _browser_width;
    CGFloat _browser_height;
}
@property (nonatomic, strong) UIScrollView *scaleView;

@end

@implementation ZZBrowserPickerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _browser_width = frame.size.width;
        _browser_height = frame.size.height;
        
        _scaleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _browser_width, _browser_height)];
        _scaleView.delegate = self;
        _scaleView.maximumZoomScale = 2.5;
        _scaleView.minimumZoomScale = 1.0;
        _scaleView.bouncesZoom = YES;
        _scaleView.multipleTouchEnabled = YES;
        _scaleView.delegate = self;
        _scaleView.scrollsToTop = NO;
        _scaleView.showsHorizontalScrollIndicator = NO;
        _scaleView.showsVerticalScrollIndicator = NO;
        _scaleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scaleView.delaysContentTouches = NO;
        _scaleView.canCancelContentTouches = YES;
        _scaleView.alwaysBounceVertical = NO;
        _scaleView.userInteractionEnabled = YES;
        [self.contentView addSubview:_scaleView];
        
        
        _pics = [[UIImageView alloc]init];
        _pics.contentMode = UIViewContentModeScaleAspectFit;
        [_scaleView addSubview:_pics];
        
        
        UITapGestureRecognizer *tapScaleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        tapScaleFingerOne.delegate = self;
        tapScaleFingerOne.numberOfTapsRequired = 1;
        [_scaleView addGestureRecognizer:tapScaleFingerOne];
        
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.delegate = self;
        singleFingerOne.numberOfTapsRequired = 1;
        [_pics addGestureRecognizer:singleFingerOne];
        
        
        UITapGestureRecognizer *singleFingerTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerTwo.delegate = self;
        singleFingerTwo.numberOfTapsRequired = 2;
        [_pics addGestureRecognizer:singleFingerTwo];

    }
    return self;
}

-(void)loadPHAssetItemForPics:(PHAsset *)assetItem
{
    PHAsset *phAsset = (PHAsset *)assetItem;
    
    CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
    CGFloat multiple = [UIScreen mainScreen].scale;
    CGFloat pixelWidth = photoWidth * multiple;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
        
        //设置BOOL判断，确定返回高清照片
        if (downloadFinined) {
            
            if (result != nil) {
                [self changeFrameWithImage:result];
                self.pics.image = result;
            }
        }
        
    }];
}

-(void)changeFrameWithImage:(UIImage *)image
{
    CGFloat height = image.size.height / image.size.width * _browser_width;
    self.pics.frame = CGRectMake(0, 0, _browser_width, height);
    self.pics.center = CGPointMake(_browser_width / 2, _browser_height / 2);
    _scaleView.contentSize = CGSizeMake(_browser_width, MAX(self.pics.frame.size.height, _browser_height));
}

-(void)setNeedsDisplay
{
    [_scaleView setZoomScale:1.0 animated:NO];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _pics;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _pics.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTapsRequired == 1) {
        if ([self.delegate respondsToSelector:@selector(clickZoomView)]) {
            [self.delegate clickZoomView];
        }
    }else if(sender.numberOfTapsRequired == 2){
        
        
        
    }
}


@end
