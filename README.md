# ZZPhotoKit
##说明

* 此开源目前接近于成熟状态，不喜欢的大神们还望轻虐。
* 注意此框架只支持 IOS 8.0 及以上系统使用。
* 注意由于工作原因后续不做IOS7适配了，IOS7占有率也比较低了，所以也不考虑后续再做了。
* 这次升级了版本之后以后可能不会有太大变动的。
* 相册多选基于最新的 Photos 框架。
* 相机连续拍摄基于AVFundation 框架。
* 图片浏览器支持 SDWebImage 加载图片
* 欢迎大家使用，欢迎大家Star

###告诉我您的APP，使用到我框架的把APP名字告诉我，谢谢哦。单纯看看使用率。(*^__^*)
###有什么不明白的地方，或者哪里需要改进的可以联系我
###联系方式
###关注微博：袁亮_

##项目介绍
![image](https://github.com/ACEYL/ZZPhotoKit/raw/master/image/demonstrate.gif)
![image](https://github.com/ACEYL/ZZPhotoKit/raw/master/image/zz_camera_intro.jpg)

##更新内容

* 10月13日更新内容：网友提出意见，图片浏览器加入放大缩小手势。点击放大缩小下一版本添加。
* 10月13日更新内容：相册多选中加入图片预览功能。
* 10月12日更新内容：对不起同志们，框架中有内存暴增问题，今日发现已经解决。在使用的同志们看见后尽快更改一下吧。或者升级一下。
* 逐步加入autolayout布局。一步一步走向横屏设备。
* iOS 10适配框架
* info.plist文件中添加相册与相机的权限
* 相册权限 Privacy - Photo Library Usage Description
* 相机权限 Privacy - Camera Usage Description
* 在iOS 10 使用时，如不添加如上权限则会导致崩溃闪退。
![image](https://github.com/ACEYL/ZZPhotoKit/raw/master/image/privacy_use.png)

##使用方法

首先重要提醒一个 文件，ZZResourceConfig.h 这个配置文件。
###包含内容

* 1.包含了所有的按钮图片信息，任意更换即可.
* 2.包含了图片返回类型的公共枚举.
* 3.所有用到的头文件。以及一些颜色、控制器宽高、屏幕宽高宏定义.

### 导入头文件
###import "ZZPhotoKit.h"

* 相册多选的调用
```
ZZPhotoController *photoController = [[ZZPhotoController alloc]init];

//设置最大选择张数
photoController.selectPhotoOfMax = 5;

[photoController showIn:self result:^(id responseObject){
	//responseObject 中元素类型为 ZZPhoto
	//返回结果集
	NSLog(@"%@",responseObject);
	NSArray *array = (NSArray *)responseObject;

}];
```

* 相机连拍的调用
```
ZZCameraController *cameraController = [[ZZCameraController alloc]init];
//设置最大连拍张数
cameraController.takePhotoOfMax = 8;
//设置图片返回类型 （下面例子为缩略图）
cameraController.imageType = ZZImageTypeOfThumb;
[cameraController showIn:self result:^(id responseObject){
	//responseObject 中元素类型为 ZZCamera
	//返回结果集
	NSLog(@"%@",responseObject);
	NSArray *array = (NSArray *)responseObject;
}];

```
### 新增model查看
* ![image](https://github.com/ACEYL/ZZPhotoKit/raw/master/image/object.png)
* ![image](https://github.com/ACEYL/ZZPhotoKit/raw/master/image/examplepic.png)

* 简单的图片浏览器
```
ZZBrowserPickerViewController *browserController = [[ZZBrowserPickerViewController alloc]init];
browserController.delegate = self;
[browserController showIn:self animation:ShowAnimationOfPush];

//delegate
//图片的个数。
-(NSInteger)zzbrowserPickerPhotoNum:(ZZBrowserPickerViewController *)controller
//图片的数组。
-(NSArray *)zzbrowserPickerPhotoContent:(ZZBrowserPickerViewController *)controller
```

###详细使用方法还是看demo 吧。
