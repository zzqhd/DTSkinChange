//
//  DTIconFontHelper.h
//  FLAnimatedImage
//
//  Created by ZzQ on 2018/7/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DTIconFontHelper : NSObject


/** 使用 "主题色" 的填充色       使用 "默认" ttf文件名 */
+ (UIImage *) getImageByUnicodeStr: (NSString *)uniCodeStr AndSize:(NSInteger)size;

/** 使用 "主题色" 的填充色     使用 "指定" ttf文件名 */
+ (UIImage *) getImageByUnicodeStr: (NSString *)uniCodeStr AndSize:(NSInteger)size fontName: (NSString *)fontName;

/** 使用 "自己指定" 的填充色    使用 "默认" ttf文件名 */
+ (UIImage *) getImageByUnicodeStr: (NSString *)uniCodeStr AndSize:(NSInteger)size Color:(UIColor *)color ;

/** 使用 "自己指定" 的填充色    使用 "指定"ttf文件名 */
+ (UIImage *) getImageByUnicodeStr: (NSString *)uniCodeStr AndSize:(NSInteger)size Color:(UIColor *)color fontName: (NSString *)fontName;


@end
