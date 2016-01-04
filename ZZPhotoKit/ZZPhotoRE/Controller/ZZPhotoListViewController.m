//
//  ZZPhotoListViewController.m
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZPhotoListViewController.h"
#import "ZZPhotoDatas.h"
#import "ZZPhotoListCell.h"
#import "ZZPhotoPickerViewController.h"
#import <Photos/Photos.h>

@interface ZZPhotoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *alumbTable;
@property(strong,nonatomic) PHPhotoLibrary *assetsLibrary;
@property(strong,nonatomic) NSMutableArray *alubms;
@property(strong,nonatomic) UIBarButtonItem *closeBtn;
@property(strong,nonatomic) ZZPhotoDatas *datas;
@end

@implementation ZZPhotoListViewController


-(UIBarButtonItem *)closeBtn{
    if (!_closeBtn) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _closeBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _closeBtn;
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 懒加载获取图片数据类
-(ZZPhotoDatas *)datas{
    if (!_datas) {
        _datas = [[ZZPhotoDatas alloc]init];
    }
    return _datas;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationItem.title = @"相册";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = self.closeBtn;
    
    _alumbTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZZ_VW, ZZ_VH) style:UITableViewStylePlain];
    _alumbTable.delegate = self;
    _alumbTable.dataSource = self;
    _alumbTable.separatorStyle = NO;
    [self.view addSubview:_alumbTable];
    
    
    
    _alubms = [NSMutableArray array];
    
    _alubms = [self.datas GetPhotoListDatas];
        
}


#pragma UITableView 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _alubms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZZPhotoListCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ZZPhotoListCell"];
    if (!cell) {
        cell = [[ZZPhotoListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ZZPhotoListCell"];
    }
    
    
    
    [cell loadPhotoListData:[_alubms objectAtIndex:indexPath.row]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZPhotoPickerViewController *photopickerController = [[ZZPhotoPickerViewController alloc]initWithNibName:nil bundle:nil];
    
    
    
    photopickerController.PhotoResult = self.photoResult;
    photopickerController.selectNum = self.selectNum;
    
    photopickerController.fetch = [self.datas GetFetchResult:[_alubms objectAtIndex:indexPath.row]];
    photopickerController.isAlubSeclect = YES;
    
    [self.navigationController pushViewController:photopickerController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
