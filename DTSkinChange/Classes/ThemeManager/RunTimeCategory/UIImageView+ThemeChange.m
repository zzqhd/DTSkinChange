//
//  UIImageView+ThemeChange.m
//  FLAnimatedImage
//
//  Created by ZzQ on 2018/7/30.
//

#import "UIImageView+ThemeChange.h"
#import "RuntimeSwizzleUtils.h"
#import "ThemeManager.h"
#import "UIView+ThemeChange.h"
@implementation UIImageView (ThemeChange)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBackgroundColor:) swappedMethod:@selector(dt_setBackgroundColor:)];
    });
}

- (void)dt_setBackgroundColor:(UIColor *)backgroundColor {
    UIColor *bgColor = [[ThemeManager shareManager] colorWithColorType:self.themeType_color];
    if (bgColor) {
        [self dt_setBackgroundColor:bgColor];
        [self.pickers setObject:bgColor forKey:@"setBackgroundColor:"];
    } else {
        [self dt_setBackgroundColor:bgColor];
    }
}

- (void)setThemeType_color:(NSString *)themeType_color {
    [super setThemeType_color:themeType_color];
    
    UIColor *color = [[ThemeManager shareManager] colorWithColorType:themeType_color];
    [self setBackgroundColor:color];
}

@end
