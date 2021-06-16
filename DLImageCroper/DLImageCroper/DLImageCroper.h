//
//  DLImageCroper.h
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DLImageItemRatioModel;
@interface DLImageCroper : UIView
- (instancetype)initWithFrame:(CGRect)frame img:(UIImage*)img;
-(void)show;

/**裁剪完成的回调block r:裁剪完成的瞬间视图相对于window的rect 当是圆形裁剪的时候r为CGRectZero
 -----------------
 Crop completion callback block r:The rect of the view relative to the window at the moment of crop completion. r is zero when cut is round*/
@property(nonatomic,copy)void(^getCropImgBlock)(UIImage * cropImg ,CGRect r);

/**比例数组
 ----------
 the ratio array*/
@property(nonatomic,retain)NSArray <DLImageItemRatioModel*>* ratioArr;

/**是否是圆形裁剪 默认NO
 --------------
 Whether it is a round cut default is NO*/
@property(nonatomic,assign)BOOL isRound;
@end

NS_ASSUME_NONNULL_END
