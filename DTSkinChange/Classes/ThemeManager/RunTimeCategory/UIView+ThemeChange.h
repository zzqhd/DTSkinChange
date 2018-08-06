//
//  UIView+ThemeChange.h
//  FLAnimatedImage
//
//  Created by ZzQ on 2018/7/26.
//

#import <UIKit/UIKit.h>

@interface UIView (ThemeChange)

/** 设置 Label背景颜色用 */
@property (nonatomic, strong) NSString *themeType_color;
/** 设置 Label背景颜色用 */
@property (nonatomic, strong) NSString *themeType_image;
/** 用来存执行的Sel方法 和设置的背景颜色 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, id> *pickers;


@end
