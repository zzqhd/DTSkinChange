//
//  TBCityIconFont.m
//  iCoupon
//
//  Created by John Wong on 10/12/14.
//  Copyright (c) 2014 Taodiandian. All rights reserved.
//

#import "TBCityIconFont.h"
#import <CoreText/CoreText.h>

@implementation TBCityIconFont

static NSString *_fontName;



+ (void)registerFontWithURL:(NSURL *)url {
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[url path]], @"Font file doesn't exist");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(newFont, nil);
    CGFontRelease(newFont);
}

/** 使用默认或者统一设置的 font文件 */
+ (UIFont *)fontWithSize:(CGFloat)size {
    return [self fontWithSize:size fontName:nil];
}

/** 使用自己单独 指定的 font文件， */
+ (UIFont *)fontWithSize:(CGFloat)size fontName:(NSString *)fontName {
    if (!fontName || [fontName isEqualToString:@""]) {
        fontName = [self fontName];
    }
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (font == nil) {
        NSURL *fontFileUrl = [[NSBundle mainBundle] URLForResource:[self fontName] withExtension:@"ttf"];
        [self registerFontWithURL: fontFileUrl];
        font = [UIFont fontWithName:[self fontName] size:size];
        NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    }
    return font;

}


#pragma mark - getter && setter

+ (void)setFontName:(NSString *)fontName {
    _fontName = fontName;
    
}


+ (NSString *)fontName {
    return _fontName ? : @"iconfont";
}

@end
