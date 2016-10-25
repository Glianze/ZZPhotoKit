//
//  ZZPhotoListModel.h
//  ZZPhotoKit
//
//  Created by 袁亮 on 16/5/19.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"
@interface ZZPhotoListModel : NSObject

/**
 照片总数
 */
@property (nonatomic, assign) NSInteger         count;

/**
 集合中最后一个实体
 */
@property (nonatomic, strong) PHAsset           *lastObject;
/**
 相册名称
 */
@property (nonatomic,   copy) NSString          *title;
/**
 结果集
 */
@property (nonatomic, strong) PHFetchResult     *fetchResult;
/**
 照片实体集合
 */
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
