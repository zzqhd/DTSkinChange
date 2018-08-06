//
//  ThemeManager.m
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "ThemeManager.h"
#import "UIColor+Hex.h"
#import "DTIconFontHelper.h"
#import "NetWorkHelper.h"

@interface ThemeManager ()


@end
@implementation ThemeManager

+ (instancetype)shareManager {
    static ThemeManager *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ThemeManager alloc] init];
        _instance.themeType = ThemeTypeDefault;
    });
    
    return _instance;
}

- (void)setThemeType:(NSString *)themeType {
    _themeType = themeType;
    
    NSString *path = nil;
    if ([themeType isEqualToString:ThemeTypeDefault]) {
        path = [[NSBundle mainBundle] pathForResource:themeType ofType:@"plist"];
    } else {
        path = [NetWorkHelper getDownFilePathBySaveName:themeType];
        NSLog(@"\nfilePath：\n%@",path);
    }
    
    _themeDic = [NSDictionary dictionaryWithContentsOfFile:path];
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeChangeNotification object:nil];
}

#pragma mark - 返回颜色
- (UIColor *)colorWithColorType:(NSString *)colorTypeStr {
    UIColor *color = nil;
    if (colorTypeStr) {
        NSLog(@"color");
    }
    if (_themeDic[colorTypeStr]) {
        NSString *colorStr = _themeDic[colorTypeStr];
        NSLog(@"🈶🈶🈶\n%@\n",colorStr);
        color = [UIColor colorWithHexString:colorStr];
    }
    
    return color;
}

#pragma mark - 返回图片
- (UIImage *)imageWithImageType:(NSString *)imageTypeStr {
    UIImage *image = nil;
    if (_themeDic[imageTypeStr]) {
        NSString *imageStr = _themeDic[imageTypeStr];

        image = [DTIconFontHelper getImageByUnicodeStr:imageStr AndSize:30];
    }
    return image;
}

#pragma mark - /** 判断是否存在主题，如不存在则去下载，下载完成后，切换主题 */
- (void) downloadAndChangeThemeWithUrl: (NSString *)urlString AndSaveName: (NSString *)saveName {
    if ([saveName isEqualToString:ThemeTypeDefault] || [NetWorkHelper fileIsExit:saveName]) {
        self.themeType = saveName;
        return;
    }
    __weak typeof(self) weakSelf = self;
    [NetWorkHelper downloadFileWithurlStr:urlString saveName:saveName downloadSuccess:^(id responseObject) {
        weakSelf.themeType = saveName;
        
    } downloadFailure:^(NSError *error) {
        
    } progress:^(float progress) {
        
    }];
}

@end

