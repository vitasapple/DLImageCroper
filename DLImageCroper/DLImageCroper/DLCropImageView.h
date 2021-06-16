//
//  DLCropImageView.h
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import <UIKit/UIKit.h>
#import "DLImageItemRatioModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface DLCropImageView : UIImageView
//点击imageView开始选择图片，若实际应用中是点击其他地方的按钮，则无需实现该block
@property(nonatomic,copy) void (^shouldChoseImageBlock)(void);

//选择完图片将图片传给DLCropImageView开始截图
-(void)sendChoseImage:(UIImage * )image;

//是否显示删除按钮，默认NO
@property(nonatomic,assign)BOOL shouldShowDelBtn;

//占位图片，用于删除按钮删除图片后imageView的显示，可不传
@property(nonatomic,retain)UIImage * placeholderImage;

/**比例数组*/
@property(nonatomic,retain)NSArray <DLImageItemRatioModel*>* ratioArr;

/**是否是圆形裁剪 默认NO
 --------------
 Whether it is a round cut default is NO*/
@property(nonatomic,assign)BOOL isRound;
@end

NS_ASSUME_NONNULL_END
