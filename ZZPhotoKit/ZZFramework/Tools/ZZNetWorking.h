//
//  ZZNetWorking.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ZZNetWorking : NSObject

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *))failure;

+(void)postlogin:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)postPic:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData dataFile:(NSString *)dataFile imageName:(NSString *)imageName success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)postPush:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
