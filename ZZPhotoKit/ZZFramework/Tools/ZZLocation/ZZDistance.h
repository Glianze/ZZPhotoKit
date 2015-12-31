//
//  ZZDistance.h
//  gywangluo
//
//  Created by yuan on 15/5/19.
//  Copyright (c) 2015年 euc. All rights reserved.
//

/**********封装通过经纬度信息计算两个经纬度之间的距离  ZZ*******/

#import <Foundation/Foundation.h>


@interface ZZDistance : NSObject

+(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2;

@end
