# DLImageCroper

[中文介绍](https://github.com/vitasapple/DLImageCroper/blob/main/chinese.md)

[blog address](https://juejin.cn/post/6974245323338153998/)

DLImageCroper provides a simple solution for capturing the current image, with five built-in aspect ratios by default

> @"1:1",@"3:4",@"origin",@"3:2",@"16:9"

DLCropImageView is provided by default for display, you just need the following code. If you don't need the built-in DLCropImageView, you can also refer to DLCropImageView to implement the related methods by yourself.

[click to see gif](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4fb889a7c67a42cf97f85a254d06040d~tplv-k3u1fbpfcp-watermark.image)

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
//option :whether to display the delete button
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```

Custom aspect ratios are also supported, such as

```
//Customize the screenshot ratio
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
self.cropView.ratioArr = arr.copy; //Customize the screenshot ratio
self.cropView.backgroundColor = [UIColor redColor];
__weak typeof(self)weakSelf = self;
self.cropView.shouldChoseImageBlock = ^{
    [weakSelf choseImage];
};
//option :whether to display the delete button
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```

[click to see gif](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7dd8ebceb6244411b5102357cb050dfc~tplv-k3u1fbpfcp-watermark.image)

Support circular cropping, just add one line of code

```
self.cropView.isRound = YES;
```

