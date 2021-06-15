//
//  NSString+DLExtension.h
//  DLImageCroper
//
//  Created by apple on 2021/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DLExtension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end

NS_ASSUME_NONNULL_END
