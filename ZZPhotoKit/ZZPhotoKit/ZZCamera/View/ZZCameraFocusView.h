//
//  ZZCameraFocusView.h
//  ZZFramework
//
//  Created by Yuan on 15/12/21.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZCameraFocusView;

@protocol ZZCameraFocusDelegate <NSObject>

@optional
-(void) cameraFocusOptionsWithPoint:(CGPoint)point;

@end

@interface ZZCameraFocusView : UIView

@property(strong,nonatomic) id <ZZCameraFocusDelegate> delegate;

@end
