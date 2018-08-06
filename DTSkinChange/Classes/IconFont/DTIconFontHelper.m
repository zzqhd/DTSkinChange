//
//  DTIconFontHelper.m
//  FLAnimatedImage
//
//  Created by ZzQ on 2018/7/30.
//

#import "DTIconFontHelper.h"
#import "UIImage+TBCityIconFont.h"
#import "TBCityIconFont.h"
#import "ThemeManager.h"

@implementation DTIconFontHelper



/** 使用 "主题色" 的填充色    使用 "默认" ttf文件名 */
+ (UIImage *)getImageByUnicodeStr:(NSString *)uniCodeStr AndSize:(NSInteger)size {
    return [self getImageByUnicodeStr:uniCodeStr AndSize:size Color:nil fontName:nil];
}

/** 使用 "主题色" 的填充色    使用 "指定" ttf文件名 */
+ (UIImage *) getImageByUnicodeStr: (NSString *)uniCodeStr AndSize:(NSInteger)size fontName: (NSString *)fontName {
    return [self getImageByUnicodeStr:uniCodeStr AndSize:size Color:nil fontName:fontName];
}

/** 使用 "自己指定" 的填充色    使用 "默认" ttf文件名 */
+ (UIImage *) getImageByUnicodeStr: (NSString *)uniCodeStr AndSize:(NSInteger)size Color:(UIColor *)color {
    return [self getImageByUnicodeStr:uniCodeStr AndSize:size Color:color fontName:nil];
}

/** 使用 "自己指定" 的填充色    使用 "指定"ttf文件名 */
+ (UIImage *) getImageByUnicodeStr: (NSString *)uniCodeStr AndSize:(NSInteger)size Color:(UIColor *)color fontName: (NSString *)fontName {
    UIImage *img = [UIImage iconWithInfo:TBCityIconInfoMake(uniCodeStr, size, color) fontName:fontName];
    return img;
}


@end
