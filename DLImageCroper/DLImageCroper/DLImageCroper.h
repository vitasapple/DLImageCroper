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
/**裁剪完成的回调block r:裁剪完成的瞬间视图相对于window的rect*/
@property(nonatomic,copy)void(^getCropImgBlock)(UIImage * cropImg ,CGRect r);
/**比例数组*/
@property(nonatomic,retain)NSArray <DLImageItemRatioModel*>* ratioArr;
@end

NS_ASSUME_NONNULL_END
