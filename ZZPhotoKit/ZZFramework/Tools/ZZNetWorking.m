//
//  ZZNetWorking.m
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ZZNetWorking.h"

@implementation ZZNetWorking
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2.发送Get请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)postlogin:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //2.发送Post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //2.发送Post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//上传图片

+(void)postPic:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData dataFile:(NSString *)dataFile imageName:(NSString *)imageName success:(void (^)(id))success failure:(void (^)(NSError *))failure

{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        [formData appendPartWithFileData :imageData name:dataFile fileName:[NSString stringWithFormat:@"%@.jpg",imageName] mimeType:@"image/jpeg"];
        
        
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

+(void)postPush:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2.发送Post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
