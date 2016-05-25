//
//  ViewController.m
//  ZZPhotoKit
//
//  Created by Yuan on 16/1/4.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ViewController.h"
#import "ZZPhotoKit.h"
#import "PicsCell.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ZZBrowserPickerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic) UILabel *firstlab;
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) NSArray *array;

@property(strong,nonatomic) UICollectionView *collectionView;
@property(strong,nonatomic) UIButton *addBtn;
@property(strong,nonatomic) NSMutableArray *picArray;

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

-(NSMutableArray *)picArray
{
    if (!_picArray) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
}

-(UIButton *)addBtn
{
    if (!_addBtn) {
        CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 30) / 4;
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, photoSize, photoSize)];
        [_addBtn setImage:[UIImage imageNamed:@"photo_add.png"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addPhotoMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[@"相册",@"相机",@"图片浏览器"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZZ_VW, 150)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    
    [self.view addSubview:_tableView];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat photoSize = (self.view.frame.size.width - 50) / 3;
    flowLayout.minimumInteritemSpacing = 10.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 10.0;//item 之间竖的距离
    flowLayout.itemSize = (CGSize){photoSize,photoSize};
    //        self.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 170, ZZ_VW - 20, photoSize * 3) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[PicsCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView setUserInteractionEnabled:YES];
    [self.view addSubview:_collectionView];
    
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
    cell.backgroundColor = [UIColor redColor];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
        photoController.selectPhotoOfMax = 8;
        //设置相册中完成按钮旁边小圆点颜色。
//        photoController.roundColor = [UIColor greenColor];
        
        [photoController showIn:self result:^(id responseObject){
            
            NSArray *array = (NSArray *)responseObject;
            NSLog(@"%@",responseObject);
            
            [self.picArray addObjectsFromArray:array];
//            NSLog(@"重载");
            [_collectionView reloadData];
            
        }];
        
        
    }else if(indexPath.row == 1){
        ZZCameraController *cameraController = [[ZZCameraController alloc]init];
        cameraController.takePhotoOfMax = 8;
        
        cameraController.isSaveLocal = NO;
        [cameraController showIn:self result:^(id responseObject){
            
            NSLog(@"%@",responseObject);
            NSArray *array = (NSArray *)responseObject;
            
            [self.picArray addObjectsFromArray:array];
            [_collectionView reloadData];
        }];
    }else if (indexPath.row == 2){
        ZZBrowserPickerViewController *browserController = [[ZZBrowserPickerViewController alloc]init];
        browserController.delegate = self;
        [browserController showIn:self animation:ShowAnimationOfPush];
    }
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


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PicsCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    if (!photoCell) {
        photoCell = [[PicsCell alloc]init];
    }
    if ([[self.picArray objectAtIndex:indexPath.row] isKindOfClass:[ZZPhoto class]]) {
        ZZPhoto *photo = [self.picArray objectAtIndex:indexPath.row];
        photoCell.photo.image = photo.image;
    }else if([[self.picArray objectAtIndex:indexPath.row] isKindOfClass:[ZZCamera class]]){
        ZZCamera *photo = [self.picArray objectAtIndex:indexPath.row];
        photoCell.photo.image = photo.image;
    }
    
    
    return photoCell;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
