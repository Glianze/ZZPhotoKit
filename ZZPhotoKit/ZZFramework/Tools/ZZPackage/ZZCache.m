//
//  ZZCache.m
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ZZCache.h"

@implementation ZZCache

+(void)saveNewsCataId:(NSString *)CatalogId Forkey:(NSString *)cacheKey
{
    NSUserDefaults *information = [NSUserDefaults standardUserDefaults];
    [information setValue:CatalogId forKey:cacheKey];
    [information synchronize];
}
+(void)removeNewsCataIdForKey:(NSString *)cacheKey
{
    NSUserDefaults *infomation = [NSUserDefaults standardUserDefaults];
    [infomation removeObjectForKey:cacheKey];
}

+(NSString *)getCacheForKey:(NSString *)cacheKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults objectForKey:cacheKey];
    return value;
}
+(void)saveCacheObject:(NSString *)String Forkey:(NSString *)cacheKey
{
    NSUserDefaults *information = [NSUserDefaults standardUserDefaults];
    [information setValue:String forKey:cacheKey];
    [information synchronize];
}

@end
