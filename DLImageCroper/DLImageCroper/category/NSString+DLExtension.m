//
//  NSString+DLExtension.m
//  DLImageCroper
//
//  Created by apple on 2021/6/15.
//

#import "NSString+DLExtension.h"

@implementation NSString (DLExtension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
