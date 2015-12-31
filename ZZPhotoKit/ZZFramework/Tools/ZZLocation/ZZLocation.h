//
//  ZZLocation.h
//  gywangluo
//
//  Created by yuan on 15/5/12.
//  Copyright (c) 2015年 euc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
@interface ZZLocation : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *street;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

+ (ZZLocation *)sharedLocation;

@end
