//
//  ZZCameraPickerViewController.m
//  ZZFramework
//
//  Created by Yuan on 15/12/18.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZCameraPickerViewController.h"
#import "ZZCameraPickerCell.h"
#import "ZZCameraFocusView.h"
#import "ZZCameraBrowerViewController.h"
#import "ZZCamera.h"
typedef void(^codeBlock)();

@interface ZZCameraPickerViewController()<UICollectionViewDelegate,UICollectionViewDataSource,ZZCameraFocusDelegate,ZZCameraBrowerDataSource>

@property (nonatomic, strong) NSMutableArray<ZZCamera *>    *cameraArray;
@property (nonatomic, strong) UICollectionView              *picsCollection;
@property (nonatomic, strong) UIView                        *downView;

@property (nonatomic, strong) AVCaptureSession              *session;
@property (nonatomic, strong) AVCaptureStillImageOutput     *captureOutput;
@property (nonatomic, strong) AVCaptureDevice               *device;

@property (nonatomic, strong) AVCaptureDeviceInput          * input;
@property (nonatomic, strong) AVCaptureMetadataOutput       * output;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer    * preview;

@end

@implementation ZZCameraPickerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)makeTopViewUI
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZZ_VW, 44)];
    if (_themeColor) {
        topView.backgroundColor = _themeColor;
    }else{
        topView.backgroundColor = [UIColor blackColor];
    }
    
    topView.alpha = 0.7f;
    [self.view addSubview:topView];
    
    //设置闪光灯默认状体为关闭
    UIButton *flashBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 7, 30, 30)];
    flashBtn.tag = 2015;
    if (self.device.flashMode == 0) {
        [flashBtn setImage:Flash_close_Btn_Pic forState:UIControlStateNormal];
    }else if(self.device.flashMode == 1){
        [flashBtn setImage:Flash_Open_Btn_Pic forState:UIControlStateNormal];
    }
    
    [flashBtn addTarget:self action:@selector(flashOfCamera:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:flashBtn];
    
    UIButton *changeBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZZ_VW - 40, 7, 30, 30)];
    [changeBtn setImage:Change_Btn_Pic forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeCameraDevice:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:changeBtn];
}


- (void)makeDownViewUI
{
    CGFloat photoSize = (ZZ_SCREEN_WIDTH - 60) / 5;
    
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, ZZ_VH - 64 - photoSize - 20, ZZ_VW, 64 + photoSize + 20)];
    if (_themeColor) {
        _downView.backgroundColor = _themeColor;
    }else{
        _downView.backgroundColor = [UIColor blackColor];
    }

    [self.view addSubview:_downView];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, photoSize + 37, 50, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:cancelBtn];
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZZ_VW - 80, photoSize + 37, 50, 30)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:doneBtn];
    
    CGFloat x = (_downView.frame.size.width - 50) / 2;
    UIButton *takePhotoBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, photoSize + 27, 50, 50)];
    [takePhotoBtn setImage:TakePhoto_Btn_Pic forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:takePhotoBtn];
    
}

- (void)makeCollectionViewUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat photoSize = (ZZ_SCREEN_WIDTH - 60) / 5;
    flowLayout.minimumInteritemSpacing = 10.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 10.0;//item 之间竖的距离
    flowLayout.itemSize = (CGSize){photoSize,photoSize};
    //        self.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _picsCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, ZZ_VW - 20, photoSize) collectionViewLayout:flowLayout];
    [_picsCollection registerClass:[ZZCameraPickerCell class] forCellWithReuseIdentifier:@"PhotoPickerCell"];
    _picsCollection.backgroundColor = [UIColor clearColor];
    _picsCollection.delegate = self;
    _picsCollection.dataSource = self;
    _picsCollection.backgroundColor = [UIColor clearColor];
    [_picsCollection setUserInteractionEnabled:YES];
    [_downView addSubview:_picsCollection];
    
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done{
    if (self.cameraArray.count == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        self.CameraResult(self.cameraArray);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)takePhoto{
    
    if (_cameraArray.count == self.takePhotoOfMax) {
        [self showAlertView:self.takePhotoOfMax];
    }else{
        [self Captureimage];
        UIView *lightScreenView = [[UIView alloc] init];
        lightScreenView.frame = self.view.bounds;
        lightScreenView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:lightScreenView];
        [UIView animateWithDuration:.5 animations:^{
            lightScreenView.alpha = 0;
        } completion:^(BOOL finished) {
            [lightScreenView removeFromSuperview];
        }];
    }
}

#pragma 懒加载Array
- (NSMutableArray *)cameraArray{
    if (!_cameraArray) {
        _cameraArray = [NSMutableArray array];
    }
    return _cameraArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initCameraMain];
    [self makeTopViewUI];
    [self makeDownViewUI];
    [self makeCollectionViewUI];
    
}

- (void)removePicItemAtIndex:(NSInteger )indexPath
{
    NSInteger index = indexPath;
    [_cameraArray removeObjectAtIndex:index];
    [_picsCollection reloadData];
}

#pragma UICollectionView --- Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cameraArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZZCameraPickerCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoPickerCell" forIndexPath:indexPath];
    if ([[self.cameraArray objectAtIndex:indexPath.row] isKindOfClass:[ZZCamera class]]) {
        ZZCamera *camera = [self.cameraArray objectAtIndex:indexPath.row];
        [photoCell loadPhotoDatas:camera.image];
    }
    
    __weak __typeof(self) weakSelf = self;
    photoCell.deleteBlock = ^(){
        [weakSelf removePicItemAtIndex:indexPath.row];
    };
    
    return photoCell;
}

#pragma UICollectionView --- Deleate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZCameraBrowerViewController *browserController = [[ZZCameraBrowerViewController alloc]init];
    browserController.delegate   = self;
    browserController.indexPath  = indexPath;
    [browserController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [browserController showIn:self];
}

#pragma mark --- ZZBrowserPickerDelegate
- (NSInteger)zzbrowserPickerPhotoNum:(ZZCameraBrowerViewController *)controller
{
    return self.cameraArray.count;;
}

- (NSArray *)zzbrowserPickerPhotoContent:(ZZCameraBrowerViewController *)controller
{
    return self.cameraArray;
}

- (void)initCameraMain
{
    //1.创建会话层
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    self.captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [self.captureOutput setOutputSettings:outputSettings];
    
    // Session
    self.session = [[AVCaptureSession alloc]init];
    
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:_captureOutput])
    {
        [self.session addOutput:_captureOutput];
    }
    
    self.preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    if (self.session) {
        [self.session startRunning];
    }
    
    [self prefersStatusBarHidden];
    
    ZZCameraFocusView *focuseView = [[ZZCameraFocusView alloc]initWithFrame:self.view.bounds];
    focuseView.delegate = self;
    [self.view addSubview:focuseView];
    
}

-(void)cameraFocusOptionsWithPoint:(CGPoint)point
{
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
        //对焦模式和对焦点
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:point];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        [self.device unlockForConfiguration];
    }
}
//对焦回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"adjustingFocus"]){
        
    }
}

- (void)Captureimage
{
    //get connection
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.captureOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    __weak typeof (self) weakSelf = self;
    [self.captureOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {

         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *t_image = [UIImage imageWithData:imageData];
         //拍摄时间
         NSDate *createDate = [NSDate date];
         //拍摄后的照片
         t_image = [weakSelf fixOrientation:t_image];

         if (self.isSavelocal == YES) {
             UIImageWriteToSavedPhotosAlbum(t_image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
         }
         
         //转model
         ZZCamera *camera  = [[ZZCamera alloc]init];
         camera.image      = t_image;
         camera.createDate = createDate;
         
         [weakSelf.cameraArray addObject:camera];
         [weakSelf.picsCollection reloadData];
     }];
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

}

- (void)changeCameraDevice:(id)sender
{
    NSArray *inputs = self.session.inputs;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            [self.session beginConfiguration];
            
            [self.session removeInput:input];
            [self.session addInput:newInput];
            
            [self.session commitConfiguration];
            break;
        }
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}

- (void) flashLightModel : (codeBlock) codeBlock{
    if (!codeBlock) return;
    [self.session beginConfiguration];
    [self.device lockForConfiguration:nil];
    codeBlock();
    [self.device unlockForConfiguration];
    [self.session commitConfiguration];
    [self.session startRunning];
}

- (void)flashOfCamera:(UIButton *)btn
{
    if (btn.tag == 2015) {
        if (self.device.flashMode == 0) {
            [self flashLightModel:^{
                [self.device setFlashMode:AVCaptureFlashModeOn];
            }];
            [btn setImage:Flash_Open_Btn_Pic forState:UIControlStateNormal];
            
        }else if (self.device.flashMode == 1){
            [self flashLightModel:^{
                [self.device setFlashMode:AVCaptureFlashModeOff];
            }];
            [btn setImage:Flash_close_Btn_Pic forState:UIControlStateNormal];
        }
    }
}

- (void)showAlertView:(NSInteger)photoNumOfMax
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:Alert_Max_TakePhoto,(long)photoNumOfMax]preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}

- (UIImage *)fixOrientation:(UIImage *)srcImg
{
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
