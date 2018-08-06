//
//  UIImage+TBCityIconFont.m
//  iCoupon
//
//  Created by John Wong on 10/12/14.
//  Copyright (c) 2014 Taodiandian. All rights reserved.
//

#import "UIImage+TBCityIconFont.h"
#import "TBCityIconFont.h"
#import <CoreText/CoreText.h>
#import "ThemeManager.h"

@implementation UIImage (TBCityIconFont)

#pragma mark - /** 使用默认的ttf文件，生成image */
+ (UIImage *)iconWithInfo:(TBCityIconInfo *)info {
    return [self iconWithInfo:info fontName:nil];
}

#pragma mark - /** 使用自己指定的ttf文件，生成image */
+ (UIImage *)iconWithInfo:(TBCityIconInfo *)info fontName: (NSString *)fontName {
    CGFloat size = info.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat realSize = size * scale;
    UIColor *color = info.color ? info.color : [[ThemeManager shareManager] colorWithColorType:themeMainColor];
    UIFont *font = [TBCityIconFont fontWithSize:realSize fontName:fontName];
    UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *realUniCodeStr = [self changeUnicodeIntoRightFormer:info.text];
    
    if ([realUniCodeStr respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        /**
         * 如果这里抛出异常，请打开断点列表，右击All Exceptions -> Edit Breakpoint -> All修改为Objective-C
         * See: http://stackoverflow.com/questions/1163981/how-to-add-a-breakpoint-to-objc-exception-throw/14767076#14767076
         */
        [realUniCodeStr drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: color}];
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextSetFillColorWithColor(context, color.CGColor);
        [realUniCodeStr drawAtPoint:CGPointMake(0, 0) withFont:font];
#pragma clang pop
    }
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSString *) changeUnicodeIntoRightFormer: (NSString *)uniCodeStr {
    NSLog(@"图片%@",uniCodeStr);
    NSString *tempStr1 = [@"\\U" stringByAppendingString:uniCodeStr];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    return returnStr;
}

@end

