//
//  UIButton+ThemeChange.m
//  FLAnimatedImage
//
//  Created by ZzQ on 2018/7/27.
//

#import "UIButton+ThemeChange.h"
#import "RuntimeSwizzleUtils.h"
#import "ThemeManager.h"
#import "UIView+ThemeChange.h"
@implementation UIButton (ThemeChange)


+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setImage:forState:) swappedMethod:@selector(dt_setImage:forState:)];
    });
}

- (void)dt_setImage:(UIImage *)image forState:(UIControlState)state {
    
    UIImage *dtImage = [[ThemeManager shareManager] imageWithImageType:self.themeType_image];
    if (dtImage) {
        [self dt_setImage:dtImage forState:state];
        [self.pickers setObject:dtImage forKey:@"dt_setImage:"];
    } else {
        [self dt_setImage:image forState:state];
    }
}

#pragma mark - 重写父类，目的可以让theme_Image在setImage后
- (void)setThemeType_image:(NSString *)themeType_image {
    [super setThemeType_image:themeType_image];
    
    UIImage *dtImage = [[ThemeManager shareManager] imageWithImageType:self.themeType_image];
    [self dt_setImage:dtImage];
}


#pragma mark - 重写系统设置Image，目的，保持pickers都是一个参数，多参数也没问题，但在这里简单处理下就好
- (void)dt_setImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateNormal];
}

@end
