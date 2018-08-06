//
//  ThemeManager.h
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemeChangeConstString.h"

@interface ThemeManager : NSObject

@property (nonatomic, strong) NSString *themeType;
@property (nonatomic, strong) NSDictionary *themeDic;


+ (instancetype)shareManager;

/** 根据类型返回相应颜色 */
- (UIColor *)colorWithColorType:(NSString *)colorTypeStr;
/** 根据类型返回相应图片 */
- (UIImage *)imageWithImageType:(NSString *)imageTypeStr;

/** 判断是否存在主题，如不存在则去下载，下载完成后，切换主题 */
- (void) downloadAndChangeThemeWithUrl: (NSString *)urlString AndSaveName: (NSString *)saveName;

@end

