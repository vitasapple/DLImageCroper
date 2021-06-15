//
//  DLImageCroperHeader.h
//  DLImageCroper
//
//  Created by apple on 2021/6/9.
//

#ifndef DLImageCroperHeader_h
#define DLImageCroperHeader_h

#import "DLImageCroper.h"
#import "DLCropImageView.h"
#import "UIImage+DLExtension.h"
#import "NSString+DLExtension.h"
static inline UIWindow * DLGetWindow(){
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

static inline CGFloat DLGetSafeAreaHeight() {
    if (@available(iOS 11.0, *)){
        return DLGetWindow().safeAreaInsets.bottom;
    }else{
        return 0.0;
    }
}
static inline UIImage * BundleImageWithName(NSString * name){
    return [UIImage imageNamed:[NSString stringWithFormat:@"DLImageCroper.bundle/%@",name]];
}

//screenwidth
#define DL_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define DL_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
//is iPhoneX and later
#define iPhoneX (KTabbarSafeBottomMargin > 0)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabbarHeight (iPhoneX ? (KTabbarSafeBottomMargin + 49) : 49)
#define KTabbarSafeBottomMargin DLGetSafeAreaHeight()

//auto size
#define SET_FIX_SIZE_WIDTH (DL_SCREEN_WIDTH /375.0)
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH//获取适配后的数据大小

//color
#define TextColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]

#endif /* DLImageCroperHeader_h */
