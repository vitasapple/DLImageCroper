//
//  DLImageCroper.h
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLImageCroper : UIView
- (instancetype)initWithFrame:(CGRect)frame img:(UIImage*)img;
//r:裁剪完成的瞬间视图相对于window的rect
@property(nonatomic,copy)void(^getCropImgBlock)(UIImage * cropImg ,CGRect r);
@end

NS_ASSUME_NONNULL_END
