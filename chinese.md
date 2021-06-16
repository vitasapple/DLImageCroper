DLImageCroper 提供一个简单的截取当前图片的简单方案，默认内置了五种宽高比例

> @"1:1",@"3:4",@"原始比例",@"3:2",@"16:9"

默认提供了DLCropImageView用于显示，只需要如下代码即可，如果你不需要内置的DLCropImageView，你也可以参照DLCropImageView自己实现相关方法。

![矩形](https://static01.imgkr.com/temp/fa8b71e4a6f84362b574798001bf036c.GIF)

用法

```
self.cropView = [[DLCropImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
self.cropView.layer.cornerRadius = 5;
self.cropView.layer.masksToBounds = YES;
self.cropView.backgroundColor = [UIColor redColor];
__weak typeof(self)weakSelf = self;
self.cropView.shouldChoseImageBlock = ^{
    [weakSelf choseImage];
};
//可选 是否显示删除按钮
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```

也支持自定义宽高比例，比如

```
//自定义截图比例
NSMutableArray * arr = [NSMutableArray new];
NSArray * nameArr = @[@"1:1",@"3:1",@"1:3"];
NSArray * valArr = @[@1, @3, @0.333];
for (int i = 0; i< 3; i++) {
    DLImageItemRatioModel * mo = [[DLImageItemRatioModel alloc]init];
    mo.name = nameArr[i];
    mo.ratio = [valArr[i] doubleValue];
    [arr addObject:mo];
}
self.cropView = [[DLCropImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
self.cropView.layer.cornerRadius = 5;
self.cropView.layer.masksToBounds = YES;
self.cropView.ratioArr = arr.copy; //自定义截图比例
self.cropView.backgroundColor = [UIColor redColor];
__weak typeof(self)weakSelf = self;
self.cropView.shouldChoseImageBlock = ^{
    [weakSelf choseImage];
};
//可选 是否显示删除按钮
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```

![圆形](https://static01.imgkr.com/temp/6b42d9bb78b8411fb517c3f0f380f72a.GIF)

支持圆形裁剪，只需加入一行代码

```
self.cropView.isRound = YES;
```

