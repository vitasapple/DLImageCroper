# DLImageCroper

[中文介绍](https://github.com/vitasapple/DLImageCroper/blob/main/chinese.md)

DLImageCroper provides a simple solution for capturing the current image, currently it provides five aspect ratios, in the near future users will be able to customize the aspect ratio and will add the image rotation function, stay tuned!

Usage

```
//Customize the screenshot scale
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
self.cropView.backgroundColor = [UIColor redColor];
self.cropView.ratioArr = arr.copy; //Customize the screenshot scale
__weak typeof(self)weakSelf = self;
self.cropView.shouldChoseImageBlock = ^{
    [weakSelf choseImage];
};
//option
self.cropView.shouldShowDelBtn = YES;
[self.view addSubview:self.cropView];
```
