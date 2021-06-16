//
//  DLImageCroper.m
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import "DLImageCroper.h"
#import "ISVImageScrollView.h"
#import "DLImageCroperHeader.h"
#import "DLImageItemRatioModel.h"
#define barHeight 50
#define itemScrollViewMinY DL_SCREEN_HEIGHT - KTabbarSafeBottomMargin - barHeight

@interface DLImageCroper()<UIScrollViewDelegate>
@property(nonatomic,retain)UIImageView * contentImgV;
@property(nonatomic,retain)CAShapeLayer * shelterLayer;
@property(nonatomic,assign)CGFloat originRate, scale , canvasHeight, startXMargin, startYMargin;
@property(nonatomic,retain)ISVImageScrollView * bgScro;
@property(nonatomic,assign)CGRect currentRect;
@property(nonatomic,assign)CGPoint offset;
@property(nonatomic,retain)UIImage * currentImg;
@property(nonatomic,retain)UIScrollView * itemScrollView;
@end
@implementation DLImageCroper


- (instancetype)initWithFrame:(CGRect)frame img:(UIImage*)img
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scale = 1;//默认1倍
        self.canvasHeight = DL_SCREEN_WIDTH;
        self.backgroundColor = [UIColor whiteColor];
        self.currentImg = img;
        self.originRate = img.size.width/img.size.height;
    }
    return self;
}
-(void)show{
    if (!_ratioArr) {
        [self setupRationArr];
    }
    [self createUI:self.currentImg];
}
#pragma mark setup methods
-(void)setupRationArr{
    NSArray * nameArr = @[@"1:1",@"3:4",@"原始比例",@"3:2",@"16:9"];
    NSArray * valArr = @[@1,@0.75, @0,@1.5, @1.778];
    NSMutableArray * arr = [NSMutableArray new];
    for (int i =0; i<nameArr.count ; i++) {
        DLImageItemRatioModel * mo = [[DLImageItemRatioModel alloc]init];
        mo.name = nameArr[i];
        mo.ratio = [valArr[i] doubleValue];
        [arr addObject:mo];
    }
    self.ratioArr = arr.copy;
}
- (void)setRatioArr:(NSArray<DLImageItemRatioModel *> *)ratioArr{
    _ratioArr = ratioArr;
}
- (void)setIsRound:(BOOL)isRound{
    _isRound = isRound;
}
#pragma mark scrollView delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _contentImgV;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    self.scale = scrollView.zoomScale;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.offset = scrollView.contentOffset;
}
#pragma mark event methods
-(void)closeBtnClick{
    [self removeFromSuperview];
}
-(void)certainBtnClick{
    CGFloat rate = 0;
    CGFloat bgscroRate = CGRectGetWidth(self.bgScro.frame) /CGRectGetHeight(self.bgScro.frame);
    CGFloat imageRate = self.currentImg.size.width /self.currentImg.size.height;
    if (bgscroRate > 1) {
        if (imageRate > 1) {
            if (bgscroRate > imageRate) {
                rate = self.currentImg.size.height / self.canvasHeight;
            }else{
                rate = self.currentImg.size.width / DL_SCREEN_WIDTH;
            }
        }else{
            rate = self.currentImg.size.height / self.canvasHeight;
        }
    }else{
        if (imageRate < 1) {
            if (bgscroRate < imageRate) {
                rate = self.currentImg.size.width / DL_SCREEN_WIDTH;
            }else{
                rate = self.currentImg.size.height / self.canvasHeight;
            }
        }else{
            rate = self.currentImg.size.width / DL_SCREEN_WIDTH;
        }
    }
    CGFloat realRate = self.scale / rate;//再根据屏幕的缩放倍率换算成相对图片的真正的缩放倍率
    CGRect  imgRect = CGRectMake(fabs(self.offset.x)/realRate,fabs(self.offset.y)/realRate, CGRectGetWidth(self.currentRect)/realRate, CGRectGetHeight(self.currentRect)/realRate);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.contentImgV.image CGImage],imgRect );
    UIImage * finalImg = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    if (self.isRound) {
        finalImg = [UIImage imageWithClipImage:finalImg];
    }
    if (self.getCropImgBlock) {
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        CGRect rect=[self.bgScro convertRect:self.bgScro.bounds toView:window];
        self.getCropImgBlock(finalImg, rect);
    }
    [self closeBtnClick];
}
-(void)createUI:(UIImage*)img{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DL_SCREEN_WIDTH, kTopHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    UILabel * lab = [UILabel new];
    lab.text = @"裁剪";
    lab.font = [UIFont systemFontOfSize:AUTO(16)];
    lab.textColor = TextColor;
    [topView addSubview:lab];
    [lab sizeToFit];
    lab.frame = CGRectMake((DL_SCREEN_WIDTH - CGRectGetWidth(lab.frame))/2.0, kStatusBarHeight, CGRectGetWidth(lab.frame), kNavBarHeight);
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:BundleImageWithName(@"close") forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(0, kStatusBarHeight, 45, 45);
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:closeBtn];
    
    UIButton * certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [certainBtn setImage:BundleImageWithName(@"打钩_白底") forState:UIControlStateNormal];
    [certainBtn addTarget:self action:@selector(certainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    certainBtn.frame = CGRectMake(DL_SCREEN_WIDTH -45, kStatusBarHeight, 45, 45);
    [topView addSubview:certainBtn];
    if (!self.isRound) {
        self.itemScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, itemScrollViewMinY, DL_SCREEN_WIDTH, KTabbarSafeBottomMargin + barHeight)];
        self.itemScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.itemScrollView];
        
        NSMutableArray * widArr = [NSMutableArray new];
        CGFloat btnw = DL_SCREEN_WIDTH/self.ratioArr.count;
        for (DLImageItemRatioModel * mo  in self.ratioArr) {
            CGFloat nameWid = [mo.name sizeWithFont:[UIFont systemFontOfSize:AUTO(15)] maxSize:CGSizeMake(DL_SCREEN_WIDTH, 20)].width;
            if (nameWid > btnw) {
                [widArr addObject:@(nameWid)];
            }else{
                [widArr addObject:@(btnw)];
            }
        }
        UIButton * lastBtn = nil;
        for (int i =0; i<self.ratioArr.count; i++) {
            DLImageItemRatioModel * mo = self.ratioArr[i];
            CGFloat wid = floor([widArr[i] doubleValue]);
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:mo.name forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(choseRateClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:AUTO(15)];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];
            btn.tag = 10 + i;
            btn.frame = CGRectMake( CGRectGetMaxX(lastBtn.frame) , 0, wid, barHeight);
            
            [self.itemScrollView addSubview:btn];
            lastBtn = btn;
        }
        self.itemScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame), CGRectGetHeight(self.itemScrollView.frame));
    }
    DLImageItemRatioModel * firstModel = self.ratioArr.firstObject;
    CGFloat hei = DL_SCREEN_WIDTH / firstModel.ratio;
    CGRect odd = CGRectZero;
    if (self.isRound) {
        odd = CGRectMake(0, (itemScrollViewMinY - DL_SCREEN_WIDTH)/2.0 + kTopHeight, DL_SCREEN_WIDTH, DL_SCREEN_WIDTH);
    }else{
        odd = CGRectMake(0, (itemScrollViewMinY - hei)/2.0 + kTopHeight, DL_SCREEN_WIDTH, hei);
    }
    self.canvasHeight = odd.size.height;
    self.currentRect = odd;
    self.bgScro = [[ISVImageScrollView alloc]initWithFrame:odd];
    self.bgScro.maximumZoomScale = 4.0;
    self.bgScro.delegate = self;
    [self addSubview:self.bgScro];
    _contentImgV = [[UIImageView alloc]initWithFrame:self.bgScro.bounds];
    _contentImgV.image = [img normalizedImage];
    [self.bgScro addSubview:_contentImgV];
    self.bgScro.imageView = _contentImgV;
    [self calculateStartXYMargin:firstModel.ratio];
    
    if (!self.isRound) {
        CGRect ff = CGRectMake(0, kTopHeight, DL_SCREEN_WIDTH, CGRectGetMinY(self.itemScrollView.frame)-kTopHeight);
        UIBezierPath * path = [UIBezierPath bezierPathWithRect:ff];
        UIBezierPath * path2 = [UIBezierPath bezierPathWithRect:odd];
        [path appendPath:path2];
        
        self.shelterLayer = [CAShapeLayer new];
        self.shelterLayer.path=path.CGPath;
        self.shelterLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.8].CGColor;
        self.shelterLayer.fillRule = kCAFillRuleEvenOdd;
        [self.layer addSublayer:self.shelterLayer];
    }else{
        self.bgScro.layer.cornerRadius = DL_SCREEN_WIDTH/2.0;
        self.bgScro.layer.masksToBounds = YES;
    }
}
-(void)calculateStartXYMargin:(CGFloat)xyRatio{
    if (self.currentImg.size.width > self.currentImg.size.height) {
        self.startXMargin = 0;
        self.startYMargin = DL_SCREEN_WIDTH / (self.currentImg.size.width/self.currentImg.size.height);
    }else{
        self.startYMargin = 0;
        self.startXMargin = DL_SCREEN_WIDTH * (self.currentImg.size.width/self.currentImg.size.height);
    }
}
-(void)choseRateClick:(UIButton *)sender{
    CGFloat minY = DL_SCREEN_HEIGHT - KTabbarSafeBottomMargin - barHeight - kTopHeight;
    CGRect ff = CGRectMake(0, kTopHeight, DL_SCREEN_WIDTH, minY);
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:ff];
    UIBezierPath * path2 = nil;
    CGRect fp = CGRectZero;
    CGFloat ratio = 0;
    DLImageItemRatioModel * mo = self.ratioArr[sender.tag - 10];
    if (mo.ratio == 0) {
        ratio = (self.currentImg.size.width/self.currentImg.size.height);
        CGFloat hei = DL_SCREEN_WIDTH /self.originRate < minY ? DL_SCREEN_WIDTH /self.originRate:minY;
        CGFloat y = (minY - hei)/2.0;
        fp = CGRectMake(0, y + kTopHeight, DL_SCREEN_WIDTH, hei);
    }else{
        ratio = mo.ratio;
        CGFloat hei = DL_SCREEN_WIDTH / mo.ratio;
        fp = CGRectMake(0, (minY - hei)/2.0 + kTopHeight, DL_SCREEN_WIDTH, hei);
    }
    if (CGRectGetHeight(fp) > minY) {
        fp = CGRectMake(0, kTopHeight, DL_SCREEN_WIDTH, minY);
    }
    self.canvasHeight = fp.size.height;
    self.bgScro.frame = fp;
    _contentImgV.frame = self.bgScro.bounds;
    [self.bgScro setZoomScale:1.0];
    self.bgScro.imageView = _contentImgV;
    [self calculateStartXYMargin:ratio];
    
    path2 = [UIBezierPath bezierPathWithRect:fp];
    self.currentRect = fp;
    [path appendPath:path2];
    self.shelterLayer.path=path.CGPath;
}
@end
