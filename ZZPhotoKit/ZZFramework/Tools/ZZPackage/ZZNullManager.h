//
//  ZZNullManager.h
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

/**********JSON数据中，对<null>标签的处理*******/

#import <Foundation/Foundation.h>

@interface ZZNullManager : NSObject

+(NSString *)nullHtmlString:(NSString *)htmlNull;

@end
