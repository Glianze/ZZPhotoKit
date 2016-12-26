//
//  ZZPhotoDatas.m
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZPhotoDatas.h"
#import "ZZPhotoListModel.h"
#import "ZZPhoto.h"
@implementation ZZPhotoDatas

- (NSArray *)GetPhotoListDatas
{
    __block NSMutableArray *dataArray = [NSMutableArray array];
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    PHFetchResult *cameraRollAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    //遍历相机胶卷
    [cameraRollAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {

        if (![collection.localizedTitle isEqualToString:@"Videos"]) {
            NSArray<PHAsset *> *assets = [self GetAssetsInAssetCollection:collection];
            ZZPhotoListModel *listModel = [[ZZPhotoListModel alloc]init];
            listModel.count = assets.count;
            listModel.title = [self FormatPhotoAlumTitle:collection.localizedTitle];
            listModel.lastObject = assets.lastObject;
            listModel.assetCollection = collection;
            [dataArray addObject:listModel];
        }
    }];
    //遍历自定义相册
    PHFetchResult *customAlbums = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOptions];
    [customAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {

        NSArray<PHAsset *> *assets = [self GetAssetsInAssetCollection:collection];
        ZZPhotoListModel *listModel = [[ZZPhotoListModel alloc]init];
        listModel.count = assets.count;
        listModel.title = collection.localizedTitle;
        listModel.lastObject = assets.lastObject;
        listModel.assetCollection = collection;
        [dataArray addObject:listModel];
    }];
    
    return [dataArray copy];
}

- (NSString *)FormatPhotoAlumTitle:(NSString *)title
{
    if ([title isEqualToString:@"All Photos"] || [title isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    return nil;
}

- (NSArray *)GetAssetsInAssetCollection:(PHAssetCollection *)assetCollection
{
    NSMutableArray<PHAsset *> *arr = [NSMutableArray array];
    PHFetchResult *result = [self GetFetchResult:assetCollection];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (((PHAsset *)obj).mediaType == PHAssetMediaTypeImage) {
            [arr addObject:obj];
        }
    }];
    return [arr copy];
}

- (PHFetchResult *)GetFetchResult:(PHAssetCollection *)assetCollection
{
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    return fetchResult;
}

- (NSArray *)GetPhotoAssets:(PHFetchResult *)fetchResult
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (PHAsset *asset in fetchResult) {
        //只添加图片类型资源，过滤除视频类型资源
        if (asset.mediaType == PHAssetMediaTypeImage) {
            ZZPhoto *photo = [[ZZPhoto alloc]init];
            photo.asset = asset;
            [dataArray addObject:photo];
        }
    }
    
    return [dataArray copy];
}

- (PHFetchResult *)GetCameraRollFetchResult
{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    
    PHFetchResult *fetch = [PHAsset fetchAssetsInAssetCollection:[smartAlbumsFetchResult objectAtIndex:0] options:nil];
    
    return fetch;
}

- (void)GetImageObject:(id)asset complection:(void (^)(UIImage *,NSURL *))complection
{
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = (PHAsset *)asset;
        
        CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat screenScale = 2.0;
        if (photoWidth > 700) {
            screenScale = 1.5;
        }
        
        CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
        CGFloat pixelWidth = photoWidth * screenScale;
        CGFloat pixelHeight = pixelWidth / aspectRatio;
        CGSize imageSize = CGSizeMake(pixelWidth, pixelHeight);
        
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        option.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:imageSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            
            UIImage *image = [self fixOrientation:result];
            //设置BOOL判断，确定返回高清照片
            if (downloadFinined) {
                NSURL *imageUrl = (NSURL *)[info objectForKey:@"PHImageFileURLKey"];
                complection(image,imageUrl);
            }
        }];
    }
}

- (BOOL)CheckIsiCloudAsset:(PHAsset *)asset
{
    CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat aspectRatio = asset.pixelWidth / (CGFloat)asset.pixelHeight;
    CGFloat multiple = [UIScreen mainScreen].scale;
    CGFloat pixelWidth = photoWidth * multiple;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.synchronous = YES;
    __block BOOL isICloudAsset = NO;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
        if([[info objectForKey:PHImageResultIsInCloudKey] boolValue]) {
            isICloudAsset = YES;
        }
    }];
    
    return isICloudAsset;
}

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
