//
//  UILabel+ThemeChange.m
//  FLAnimatedImage
//
//  Created by ZzQ on 2018/7/26.
//

#import "UILabel+ThemeChange.h"
#import "RuntimeSwizzleUtils.h"
#import "ThemeManager.h"
#import "UIView+ThemeChange.h"
@implementation UILabel (ThemeChange)


+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTextColor:) swappedMethod:@selector(dt_setTextColor:)];
    });
}

- (void)dt_setTextColor:(UIColor *)color {
    UIColor *textColor = [[ThemeManager shareManager] colorWithColorType:self.themeType_color];
    if (textColor) {
        [self dt_setTextColor:textColor];
        [self.pickers setObject:textColor forKey:@"setTextColor:"];
    } else {
        [self dt_setTextColor:color];
    }
}

- (void)setThemeType_color:(NSString *)themeType_color {
    [super setThemeType_color:themeType_color];
    
    UIColor *textColor = [[ThemeManager shareManager] colorWithColorType:themeType_color];
    [self setTextColor:textColor];
}


@end
