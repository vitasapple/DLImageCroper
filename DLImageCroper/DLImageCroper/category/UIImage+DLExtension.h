//
//  UIImage+DLExtension.h
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DLExtension)
- (UIImage *)normalizedImage;
+(UIImage*)view2Image:(UIView*)v;
+ (UIImage *)imageWithClipImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
