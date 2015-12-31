//
//  ZZLocation.m
//  gywangluo
//
//  Created by yuan on 15/5/12.
//  Copyright (c) 2015年 euc. All rights reserved.
//

#import "ZZLocation.h"

@interface ZZLocation()<CLLocationManagerDelegate>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(strong,nonatomic) CLLocationManager *locationmanager;
@property(strong,nonatomic) CLGeocoder *geocoder;

@end
@implementation ZZLocation

+(ZZLocation *)sharedLocation
{
    static ZZLocation *zzlocation = nil;
    if (zzlocation == nil) {
        zzlocation = [[ZZLocation alloc]init];
    }
    return zzlocation;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.coordinate = CLLocationCoordinate2DMake(0, 0);
        self.locationmanager = [[CLLocationManager alloc]init];
        
        if (IOS_VERSION >= 8.0) {
            [self.locationmanager requestAlwaysAuthorization];
        }
        self.locationmanager.delegate = self;
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationmanager.distanceFilter = 50.0f;
        
        [self.locationmanager startUpdatingLocation];//开始定位
        
    }
    return self;
}

#pragma mark - CLLocationDelegate


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.geocoder = [[CLGeocoder alloc]init];
    CLLocation * location = [locations firstObject];
    
    
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
    
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString *subLocality = placemark.subLocality ? placemark.subLocality : @"";
        NSString *thoroughfare = placemark.thoroughfare ? placemark.thoroughfare : @"";
        NSString *subThoroughfare = placemark.subThoroughfare ? placemark.subThoroughfare : @"";
        
        self.address = [NSString stringWithFormat:@"%@%@%@", subLocality, thoroughfare, subThoroughfare];
        self.area = subLocality;
        self.street = thoroughfare;
        if (placemark.locality)
            self.city = placemark.locality;
        else
            self.city = placemark.administrativeArea;
        
    }];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];//失败后停止定位
}
-(void)location2Geo:(CLLocation *)location
{
    NSLog(@"执行1");
    NSLog(@"======");
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        
        if (error == nil && placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%@",placemark);
        }
        
        
    }];
}

@end
