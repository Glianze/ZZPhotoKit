//
//  ZZDate.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.



/**********封装获取日期时间  ZZ*******/

#import <Foundation/Foundation.h>

@interface ZZDate : NSObject

+(NSString *)putDateOfyyyyMMdd:(NSString *)date;

+(NSString *)putDateOfyyyyMMddHHmm:(NSString *)date;

//获取当前时间精确到秒
+(NSString *)getNowDataOfyyyMMddHHmmss;

//创建所上传照片的名字，使用时间来命名
+(NSString *)getNowDataOfyyyMMddHHmmssByAppending:(NSString *)fileName;

@end
