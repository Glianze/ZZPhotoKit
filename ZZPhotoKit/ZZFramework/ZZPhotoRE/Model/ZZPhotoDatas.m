//
//  ZZPhotoDatas.m
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZPhotoDatas.h"

@implementation ZZPhotoDatas


-(NSMutableArray *)GetPhotoListDatas
{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    
    [dataArray addObject:[smartAlbumsFetchResult objectAtIndex:0]];
    
    PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOptions];
    
    for (PHAssetCollection *sub in smartAlbumsFetchResult1)
    {
        [dataArray addObject:sub];
    }
    
    return dataArray;
}

-(PHFetchResult *)GetFetchResult:(PHAssetCollection *)assetCollection
{
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    
    return fetchResult;
    
}

-(NSMutableArray *)GetPhotoAssets:(PHFetchResult *)fetchResult
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (PHAsset *asset in fetchResult) {
        //只添加图片类型资源，去除视频类型资源
        //当mediaType == 2时，这个资源则为视频资源
        if (asset.mediaType == 1) {
            [dataArray addObject:asset];
        }
        
    }
    return dataArray;
}

-(PHFetchResult *)GetCameraRollFetchResul
{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    
    
    PHFetchResult *fetch = [PHAsset fetchAssetsInAssetCollection:[smartAlbumsFetchResult objectAtIndex:0] options:nil];
    return fetch;
}
-(NSMutableArray *)GetImageObject:(NSMutableArray *)picArray
{
    
    NSMutableArray *imageObject = [NSMutableArray array];
    
    for (int i = 0; i < picArray.count; i++) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:[picArray objectAtIndex:i]
                                                   targetSize:PHImageManagerMaximumSize
                                                  contentMode:PHImageContentModeDefault
                                                      options:options
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    
                                                    [imageObject addObject:result];
                                                    
                                                }];
    }
    
    return imageObject;
}
@end
