//
//  ZZNullManager.m
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ZZNullManager.h"

@implementation ZZNullManager

+(NSString *)nullHtmlString:(NSString *)htmlNull
{
    NSString *objectString = [[NSString alloc]init];
    if ([htmlNull isEqual:[NSNull null]]) {
        
    }else{
        objectString = htmlNull;
    }
    return objectString;
}

@end
