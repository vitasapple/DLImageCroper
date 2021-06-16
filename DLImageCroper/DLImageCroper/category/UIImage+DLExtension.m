//
//  UIImage+DLExtension.m
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#import "UIImage+DLExtension.h"

@implementation UIImage (DLExtension)
- (UIImage *)normalizedImage {
     if (self.imageOrientation == UIImageOrientationUp) return self;
  
     UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
     [self drawInRect:(CGRect){0, 0, self.size}];
     UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return normalizedImage;
 }
+(UIImage*)view2Image:(UIView*)v{
    CGRect rect = v.frame;
//    if ([v isKindOfClass:[UIScrollView class]]) {
//        rect.size = ((UIScrollView *)v).contentSize;
//    }
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)imageWithClipImage:(UIImage *)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [path addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
