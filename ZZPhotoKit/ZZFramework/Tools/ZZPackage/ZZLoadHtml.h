//
//  ZZLoadHtml.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

/**********解析HTML，去掉HTML标签*******/

#import <Foundation/Foundation.h>

@interface ZZLoadHtml : NSObject
+(NSString *)filterHTML:(NSString *)html;
@end
