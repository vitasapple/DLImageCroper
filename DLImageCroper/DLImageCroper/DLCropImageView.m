//
//  DLCropImageView.m
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import "DLCropImageView.h"
#import "DLImageCroper.h"
#import "DLImageCroperHeader.h"
@interface DLCropImageView()
@property(nonatomic,retain)UIButton * delBtn;
@end
@implementation DLCropImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)tapClick{
    if (self.shouldChoseImageBlock) {
        self.shouldChoseImageBlock();
    }
}
- (void)setRatioArr:(NSArray<DLImageItemRatioModel *> *)ratioArr{
    _ratioArr = ratioArr;
}
- (void)setIsRound:(BOOL)isRound{
    _isRound = isRound;
}
-(void)sendChoseImage:(UIImage * )image{
    DLImageCroper * crop = [[DLImageCroper alloc]initWithFrame:CGRectMake(0, 0, DL_SCREEN_WIDTH, DL_SCREEN_HEIGHT) img:image];
    crop.ratioArr = self.ratioArr;
    crop.isRound = self.isRound;
    crop.getCropImgBlock = ^(UIImage * _Nonnull cropImg, CGRect r) {
        UIImageView * tmpView = [[UIImageView alloc]initWithFrame:r];
        tmpView.image = cropImg;
        if (self.layer.cornerRadius > 0) {
            tmpView.layer.cornerRadius = self.layer.cornerRadius;
            tmpView.layer.masksToBounds = YES;
        }
        [[self currentViewController].view addSubview:tmpView];
        CGRect targetRect = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        [UIView animateWithDuration:0.5 animations:^{
            tmpView.frame = targetRect;
        }completion:^(BOOL finished) {
            self.image = cropImg;
            [tmpView removeFromSuperview];
            if (self.delBtn && self.delBtn.isHidden) {
                self.delBtn.hidden = !self.shouldShowDelBtn;
            }
        }];
    };
    [[self currentViewController].view addSubview:crop];
    [crop show];
    if (self.shouldShowDelBtn) {
        [self addSubview:self.delBtn];
    }
}
- (void)setShouldShowDelBtn:(BOOL)shouldShowDelBtn{
    _shouldShowDelBtn = shouldShowDelBtn;
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage = placeholderImage;
}
- (UIButton *)delBtn{
    if (!_delBtn) {
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setImage:BundleImageWithName(@"关闭") forState:UIControlStateNormal];
        _delBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - 20, 0, 20, 20);
        _delBtn.hidden = YES;
        [_delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}
-(void)delBtnClick{
    self.delBtn.hidden = YES;
    if (self.placeholderImage) {
        self.image = self.placeholderImage;
    }else{
        self.image = nil;
    }
}
-(UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
@end
