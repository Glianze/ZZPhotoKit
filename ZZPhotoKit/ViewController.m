//
//  ViewController.m
//  ZZPhotoKit
//
//  Created by Yuan on 16/1/4.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ViewController.h"
#import "ZZPhotoController.h"
#import "ZZCameraController.h"
#import "ZZBrowserPickerViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ZZBrowserPickerDelegate>
@property(strong,nonatomic) UILabel *firstlab;
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) NSArray *array;

@end

@implementation ViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"ZZPhotoKit";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[@"相册",@"相机",@"图片浏览器"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZZ_VW, 214)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    
    [self.view addSubview:_tableView];
    
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 214, ZZ_VW, ZZ_VH - 214)];
    //    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
        photoController.selectPhotoOfMax = 5;
        photoController.imageType = ZZImageTypeOfDefault;
        
        [photoController showIn:self result:^(id responseObject){
            NSLog(@"%@",responseObject);
            NSArray *array = (NSArray *)responseObject;
            
            UIImage *image = [array objectAtIndex:0];
            _imageView.image = image;
        }];
        
    }else if(indexPath.row == 1){
        ZZCameraController *cameraController = [[ZZCameraController alloc]init];
        cameraController.takePhotoOfMax = 8;
        cameraController.imageType = ZZImageTypeOfDefault;
        [cameraController showIn:self result:^(id responseObject){
            
            NSLog(@"%@",responseObject);
            NSArray *array = (NSArray *)responseObject;
            
            UIImage *image = [array objectAtIndex:0];
            _imageView.image = image;
        }];
    }else if (indexPath.row == 2){
        ZZBrowserPickerViewController *browserController = [[ZZBrowserPickerViewController alloc]init];
        browserController.delegate = self;
        [browserController showIn:self animation:ShowAnimationOfPush];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark --- ZZBrowserPickerDelegate
-(NSInteger)zzbrowserPickerPhotoNum:(ZZBrowserPickerViewController *)controller
{
    return 5;
}

-(NSArray *)zzbrowserPickerPhotoContent:(ZZBrowserPickerViewController *)controller
{
    NSArray *array = @[
                       @"http://pic86.nipic.com/file/20151229/11592367_090842563000_2.jpg",
                       [UIImage imageNamed:@"scv2.jpg"],
                       [UIImage imageNamed:@"scv3.jpg"],
                       [UIImage imageNamed:@"scv4.jpg"],
                       [UIImage imageNamed:@"scv5.jpg"],
                       ];
    return array;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
