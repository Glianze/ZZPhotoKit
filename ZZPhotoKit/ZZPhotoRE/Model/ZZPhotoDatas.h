//
//  ZZPhotoDatas.h
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
@interface ZZPhotoDatas : NSObject

@property(assign,nonatomic) NSInteger type;

/*
 *    获取全部相册
 */
-(NSMutableArray *) GetPhotoListDatas;
/*
 *    获取某一个相册的结果集
 */
-(PHFetchResult *) GetFetchResult:(PHAssetCollection *)asset;
/*
 *    获取图片实体，并把图片结果存放到数组中，返回值数组
 */
-(NSMutableArray *) GetPhotoAssets:(PHFetchResult *)fetchResult;
/*
 *    只获取相机胶卷结果集
 */
-(PHFetchResult *) GetCameraRollFetchResul;



/*
 *    回调方法使用数组
 */
-(void) GetImageObject:(id)asset complection:(void (^)(UIImage *, BOOL isDegraded))complection;
@end
