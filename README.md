# DLImageCroper

DLImageCroper provides a simple solution for capturing the current image, currently it provides five aspect ratios, in the near future users will be able to customize the aspect ratio and will add the image rotation function, stay tuned!

Usage

```
self.cropView = [[DLCropImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
self.cropView.layer.cornerRadius = 5;
self.cropView.layer.masksToBounds = YES;
self.cropView.backgroundColor = [UIColor redColor];
__weak typeof(self)weakSelf = self;
self.cropView.shouldChoseImageBlock = ^{
    [weakSelf choseImage];
};
//option
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```

中文介绍：

DLImageCroper 提供一个简单的截取当前图片的简单方案，目前提供了五种宽高比例，在不久的将来用户将可以自定义宽高比例，并且会加入图片旋转功能，敬请期待

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
//可选
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```

