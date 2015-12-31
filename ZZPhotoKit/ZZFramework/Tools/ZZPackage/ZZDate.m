//
//  ZZDate.m
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ZZDate.h"

@implementation ZZDate
+(NSString *)putDateOfyyyyMMdd:(NSString *)date
{
    NSString *timeStr = date;
    NSTimeInterval timeInterval = [timeStr doubleValue];
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *resultFormatter=[[NSDateFormatter alloc]init];
    [resultFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [resultFormatter stringFromDate:pubDate];
    
    return time;
}
+(NSString *)putDateOfyyyyMMddHHmm:(NSString *)date
{
    NSString *timeStr = date;
    NSTimeInterval timeInterval = [timeStr doubleValue];
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *resultFormatter=[[NSDateFormatter alloc]init];
    [resultFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *time = [resultFormatter stringFromDate:pubDate];
    
    return time;
}
+(NSString *)getNowDataOfyyyMMddHHmmss
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate date]];
    
    return nowTimeStr;
}
+(NSString *)getNowDataOfyyyMMddHHmmssByAppending:(NSString *)fileName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *newName = [NSString stringWithFormat:@"Cmd%@",nowTimeStr];
    
    NSString *jpgorderName = [newName stringByAppendingString:fileName];
    
    return jpgorderName;
}

@end
