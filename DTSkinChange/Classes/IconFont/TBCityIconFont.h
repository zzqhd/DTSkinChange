//
//  TBCityIconFont.h
//  iCoupon
//
//  Created by John Wong on 10/12/14.
//  Copyright (c) 2014 Taodiandian. All rights reserved.
//

#import "UIImage+TBCityIconFont.h"
#import "TBCityIconInfo.h"

#define TBCityIconInfoMake(text, imageSize, imageColor) [TBCityIconInfo iconInfoWithText:text size:imageSize color:imageColor]

@interface TBCityIconFont : NSObject

/** 使用默认或者统一设置的 font文件 */
+ (UIFont *)fontWithSize: (CGFloat)size;
/** 使用自己单独 指定的 font文件， */
+ (UIFont *)fontWithSize: (CGFloat)size fontName: (NSString *)fontName;

/** 可在delegate中设置一次，const 的 */
+ (void)setFontName:(NSString *)fontName;

@end
