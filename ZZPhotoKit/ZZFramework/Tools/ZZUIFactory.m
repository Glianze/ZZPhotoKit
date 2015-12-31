//
//  ZZUIFactory.m
//  ZZFramework
//
//  Created by yuan on 15/6/8.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ZZUIFactory.h"

@implementation ZZUIFactory
+(UIButton *)createrect:(CGRect)frame createname:(NSString *)btnName action:(SEL) action
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:btnName forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor blueColor];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [[UIColor grayColor] CGColor];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIBarButtonItem *)createFontBtn:(CGRect)frame text:(NSString *)text target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *backBtnView = [[UIView alloc] initWithFrame:button.bounds];
    [backBtnView addSubview:button];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    
    return backBarBtn;
}

+(UIBarButtonItem *)createBackButton:(CGRect)frame image:(UIImage *)image target:(id)target action:(SEL)selector;
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *backBtnView = [[UIView alloc] initWithFrame:button.bounds];
    [backBtnView addSubview:button];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    
    return backBarBtn;
}
+(UIView *)createrect:(CGRect)frame createImage:(UIImage *)image createHeightedImage:(UIImage *)heightedImage action:(SEL)action
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:heightedImage forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    return view;
}

+(UIButton *)createrect:(CGRect)frame heightImage:(UIImage *)heightimage toolPicture:(UIImage *)toolpicture toolName:(NSString *)toolname action:(SEL)action
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:heightimage forState:UIControlStateHighlighted];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    imageview.image = toolpicture;
    [button addSubview:imageview];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageview.right +10, 10, 40, 40)];
    label.text = toolname;
    
    [button addSubview:label];
    return button;
}
+(UIBarButtonItem *)createRightButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)selector
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.0 green:0.725 blue:1.0 alpha:1.0]] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    
    UIView *backBtnView = [[UIView alloc] initWithFrame:button.bounds];
    backBtnView.layer.cornerRadius = 3;
    backBtnView.layer.masksToBounds = YES;
    backBtnView.layer.borderWidth = 1;
    backBtnView.layer.borderColor = [[UIColor colorWithRed:234.0 / 255.0 green:234.0 / 255.0 blue:234.0 / 255.0 alpha:1] CGColor];
    [backBtnView addSubview:button];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    
    return backBarBtn;
}
+(UILabel *)context:(NSString *)context
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    
    label.textColor = RGB(102, 102, 102);
    
    [label setNumberOfLines:0];
    
    NSString *alertText = context;
    
    label.text = alertText;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    label.font = font;
    
    CGSize labelsize = [alertText sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    [label setFrame:CGRectMake(100, 25 - labelsize.height / 2, labelsize.width, labelsize.height)];
    
    return label;
}
+(UIView *)viewRect:(CGRect)viewframe  imageRect:(CGRect)imageframe addImage:(NSString *)imageNamed labelText:(NSString *)text
{
    
    UIView *view = [[UIView alloc]initWithFrame:viewframe];
    UIImageView *image = [[UIImageView alloc]initWithFrame:imageframe];
    image.image = [UIImage imageNamed:imageNamed];
    [view addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(image.right +10, 18, view.width - image.frame.origin.x - 10, 14)];
    label.text = text;
    [view addSubview:label];
    
    return view;
}

+(UILabel *)newsNav:(NSString *)context
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    
    label.textColor = RGB(51, 51, 51);
    
    [label setNumberOfLines:0];
    
    NSString *alertText = context;
    
    label.text = alertText;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    
    label.font = font;
    
    CGSize labelsize = [alertText sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    [label setFrame:CGRectMake(100, 25 - labelsize.height / 2, labelsize.width, labelsize.height)];
    
    return label;
}
+(UIButton *)pullBtnRect:(CGRect)frame pullBtnTitle:(NSString *)title normalImage:(UIImage *)namalImage selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor whiteColor];
    CGFloat viewX = button.frame.size.width / 2 - button.frame.size.width / 4;
    CGFloat viewY = button.frame.size.height / 2 - button.frame.size.height / 4;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(viewX, viewY, button.frame.size.width / 2, button.frame.size.height / 2)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width / 1.5, view.height)];
    label.text = title;
    [view addSubview:label];
    
    CGFloat imageViewY = view.height / 2 - view.height / 3 / 2;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(label.right + 5, imageViewY, view.width - label.width - 5, view.height / 3)];
    
    //    button.selected = !button.selected;
    
    if (!button.selected) {
        imageView.image = namalImage;
    }else{
        imageView.image = selectedImage;
    }
    
    [view addSubview:imageView];
    
    
    [button addSubview:view];
    
    return button;
}
+(UIBarButtonItem *)createNavItem:(CGRect)frame image:(UIImage *)image target:(id)target action:(SEL)action
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    return item;
    
}
+(UIView *)createMenu:(CGRect)frame topImage:(NSString *)topImage downImage:(NSString *)downImage addCollectionView:(UIView *)view
{
    UIView *menuView = [[UIView alloc]initWithFrame:frame];
    
    UIImageView *upImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
    upImage.image = [UIImage imageNamed:topImage];
    [menuView addSubview:upImage];
    
    UIView *incollectionView = [[UIView alloc]initWithFrame:CGRectMake(0, upImage.bottom, menuView.width, menuView.height - 8)];
    
    UIImageView *lowImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, menuView.height - 8)];
    lowImage.image = [UIImage imageNamed:downImage];
    [incollectionView addSubview:lowImage];
    
    
    [menuView addSubview:incollectionView];
    [incollectionView addSubview:view];
    
    return menuView;
}
+(UIView *)createValuNum:(CGRect)frame ValuNum:(int)valuNum
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = RGB(243, 243, 243);
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [RGB(153, 153, 153) CGColor];
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 5.0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 13, 11)];
    imageView.image = [UIImage imageNamed:@"huifuNum"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 5, 5, view.width - 28, 11)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label.textColor = RGB(153, 153, 153);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d",valuNum];
    
    [view addSubview:label];
    
    return view;
}

+(UIBarButtonItem *)createSearchBar:(CGRect)frame target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:@"search_btn"] forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return backBarBtn;
}

@end
