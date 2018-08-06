//
//  UIView+ThemeChange.m
//  FLAnimatedImage
//
//  Created by ZzQ on 2018/7/26.
//

#import "UIView+ThemeChange.h"
#import <objc/runtime.h>
#import "ThemeManager.h"

@implementation UIView (ThemeChange)

static char *ThemeChangeTextColorKey = "ThemeChangeTextColorKey";
static char *ThemeChangePickers = "ThemeChangeTextColorKey";
static char *ThemeChangeImageKey = "ThemeChangeImageKey";




#pragma mark - 接收通知，更新UI

- (void) updateTheme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id obj, BOOL * _Nonnull stop) {
        SEL selector = NSSelectorFromString(key);
        [UIView animateWithDuration:0.3 animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:obj];
#pragma clang diagnostic pop
        }];
    }];
}




#pragma mark - getter && setter
- (NSMutableDictionary<NSString *,id> *)pickers {
    NSMutableDictionary <NSString *, id> *pickers = objc_getAssociatedObject(self, &ThemeChangePickers);
    if (!pickers) {
        pickers = @{}.mutableCopy;
        objc_setAssociatedObject(self, &ThemeChangePickers, pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeChangeNotification object:nil];
    }
    return pickers;
}


/** 设置颜色 */
- (void)setThemeType_color:(NSString *)themeType_color {
    objc_setAssociatedObject(self, &ThemeChangeTextColorKey, themeType_color, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)themeType_color {
    return objc_getAssociatedObject(self, &ThemeChangeTextColorKey);
}

/** 设置背景图片 */
- (void)setThemeType_image:(NSString *)themeType_image {
    objc_setAssociatedObject(self, &ThemeChangeImageKey, themeType_image, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)themeType_image {
    return objc_getAssociatedObject(self, &ThemeChangeImageKey);
}

@end
