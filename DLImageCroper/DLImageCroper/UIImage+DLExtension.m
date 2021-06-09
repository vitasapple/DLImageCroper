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
@end
