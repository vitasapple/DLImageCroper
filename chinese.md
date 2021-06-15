DLImageCroper 提供一个简单的截取当前图片的简单方案，目前提供了五种宽高比例，在不久的将来用户将可以自定义宽高比例，并且会加入图片旋转功能，敬请期待

用法

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
//self.cropView.ratioArr = arr.copy; //自定义截图比例
self.cropView.backgroundColor = [UIColor redColor];
__weak typeof(self)weakSelf = self;
self.cropView.shouldChoseImageBlock = ^{
    [weakSelf choseImage];
};
//可选
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```

