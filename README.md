# ZZPhotoKit
##说明

* 此开源目前接近于成熟状态，不喜欢的大神们还望轻虐。
* 目前只支持 IOS 8.0 及以上系统使用。
* 框架代码以及功能正在养成中。
* 相册多选基于最新的 Photos 框架。
* 相机连续拍摄基于AVFundation 框架。
* 图片浏览器支持 SDWebImage 加载图片
* 欢迎大家使用，欢迎大家Star

###有什么不明白的地方，或者哪里需要改进的可以联系我
###联系方式
###关注微博：袁亮_  *** QQ:412016060

##项目Gif介绍
![image](https://github.com/ACEYL/ZZPhotoKit/raw/master/image/demonstrate.gif)

##更新内容

* 修复图片浏览器浏览图片卡顿问题。
* 框架中加入两个model，ZZPhoto、ZZCamera。里面包含图片，图片地址和照片创建时间。详见demo
* 更新ZZCamera文件夹下目录结构
* 修复图片浏览器不定位滚动问题。
* 新增ZZCameraController自动对焦视图自动消失功能。
* 修复闪光灯是否开启按钮与闪光灯不统一bug，闪光灯默认为不开启状态。

##使用方法

首先重要提醒一个 文件，Common.h 这个配置文件。
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
	//返回结果集
	NSLog(@"%@",responseObject);
	NSArray *array = (NSArray *)responseObject;

	UIImage *image = [array objectAtIndex:0];
	_imageView.image = image;
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
	//返回结果集
	NSLog(@"%@",responseObject);
	NSArray *array = (NSArray *)responseObject;

	UIImage *image = [array objectAtIndex:0];
	_imageView.image = image;
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
