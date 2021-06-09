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
