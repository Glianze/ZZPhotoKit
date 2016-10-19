//
//  ZZCameraBrowerCell.h
//  ZZPhotoKit
//
//  Created by 袁亮 on 16/10/19.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZCameraBrowerCellDelegate <NSObject>

- (void) clickSingleFingerAtScreen;

@end

@interface ZZCameraBrowerCell : UICollectionViewCell

@property (nonatomic,   weak) id<ZZCameraBrowerCellDelegate>delegate;

-(void) loadPicData:(UIImage *) image;

-(void) recoverSubview;

@end
