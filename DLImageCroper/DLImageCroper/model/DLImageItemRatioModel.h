//
//  DLImageItemRatioModel.h
//  DLImageCroper
//
//  Created by apple on 2021/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLImageItemRatioModel : NSObject
/**ex:
 --------------------
 16:9 */
@property(nonatomic,copy)NSString * name;

/**0表示原始比例
 --------------------
 0 represents the original ratio */
@property(nonatomic,assign)CGFloat ratio;

@end

NS_ASSUME_NONNULL_END
