//
//  UIImage+TBCityIconFont.h
//  iCoupon
//
//  Created by John Wong on 10/12/14.
//  Copyright (c) 2014 Taodiandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCityIconInfo.h"

@interface UIImage (TBCityIconFont)

/** 使用默认的ttf文件，生成image */
+ (UIImage *)iconWithInfo:(TBCityIconInfo *)info;
/** 使用自己指定的ttf文件，生成image */
+ (UIImage *)iconWithInfo:(TBCityIconInfo *)info fontName: (NSString *)fontName;

@end
