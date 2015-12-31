//
//  ZZCache.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

/**********数据持久化本地轻量级数据*******/

#import <Foundation/Foundation.h>

@interface ZZCache : NSObject

+(void)saveNewsCataId:(NSString *)CatalogId Forkey:(NSString *)cacheKey;

+(void)removeNewsCataIdForKey:(NSString *)cacheKey;

+(NSString *)getCacheForKey:(NSString *)cacheKey;

+(void)saveCacheObject:(NSString *)String Forkey:(NSString *)cacheKey;

@end
