//
//  NetWorkHelper.h
//  SkinChangeDemo
//
//  Created by ZzQ on 2018/8/3.
//  Copyright © 2018年 ZzQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetWorkHelper : NSObject


/**
 下载 ttf文件或者 Plist文件

 @param urlStr URL
 @param saveName 保存到本地的文件名 包含后缀
 @param progress 进度
 */
+ (void)downloadFileWithurlStr:(NSString *)urlStr
                     saveName:(NSString *)saveName
               downloadSuccess:(void (^)(id responseObject))success
               downloadFailure:(void (^)(NSError *error))failure
                      progress:(void (^)(float progress))progress ;

/** 根据文件名，找到下载到本地的路径 */
+ (NSString *)getDownFilePathBySaveName: (NSString *)saveName;

/** 根据saveName判断是否存在 */
+ (BOOL) fileIsExit: (NSString *)saveName;
@end
