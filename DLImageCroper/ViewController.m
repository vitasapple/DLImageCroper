//
//  ViewController.m
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import "ViewController.h"
#import "DLCropImageView.h"
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,retain)DLCropImageView * cropView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
-(void)createUI{
    //自定义截图比例
    NSMutableArray * arr = [NSMutableArray new];
    NSArray * nameArr = @[@"3:1",@"1:1",@"1:3"];
    NSArray * valArr = @[@3,@1,@0.333];
    for (int i = 0; i< 3; i++) {
        DLImageItemRatioModel * mo = [[DLImageItemRatioModel alloc]init];
        mo.name = nameArr[i];
        mo.ratio = [valArr[i] doubleValue];
        [arr addObject:mo];
    }
    
    self.cropView = [[DLCropImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.cropView.layer.cornerRadius = 5;
//    self.cropView.isRound = YES;
    self.cropView.layer.masksToBounds = YES;
    self.cropView.backgroundColor = [UIColor redColor];
    self.cropView.ratioArr = arr.copy; //自定义截图比例
    __weak typeof(self)weakSelf = self;
    self.cropView.shouldChoseImageBlock = ^{
        [weakSelf choseImage];
    };
    //可选
    self.cropView.shouldShowDelBtn = YES;
    [self.view addSubview:self.cropView];
}
-(void)choseImage{
    UIImagePickerController *pickerCtr = [[UIImagePickerController alloc] init];
    pickerCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerCtr.delegate = self;
    [self presentViewController:pickerCtr animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //process image
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.cropView sendChoseImage:image];
        }];
    }
}
@end
