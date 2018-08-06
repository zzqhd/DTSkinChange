//
//  NetWorkHelper.m
//  SkinChangeDemo
//
//  Created by ZzQ on 2018/8/3.
//  Copyright © 2018年 ZzQ. All rights reserved.
//

#import "NetWorkHelper.h"

@implementation NetWorkHelper

+ (void)downloadFileWithurlStr:(NSString *)urlStr
                      saveName:(NSString *)saveName
               downloadSuccess:(void (^)(id responseObject))success
               downloadFailure:(void (^)(NSError *error))failure
                      progress:(void (^)(float progress))progress {
    
    //沙盒路径
    NSString *filePath = [self getDownFilePathBySaveName:saveName];
    NSLog(@"下载沙盒路径%@",filePath);
    /** 发起请求 */
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:filePath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    /** 设置回调 */
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
}

#pragma mark - /** 根据文件名，找到下载到本地的路径 */
+ (NSString *)getDownFilePathBySaveName: (NSString *)saveName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:saveName];
    return filePath;
}


#pragma mark - /** 根据saveName判断是否存在 */
+ (BOOL) fileIsExit: (NSString *)saveName {
    NSString *filePath = [self getDownFilePathBySaveName:saveName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //Get documents directory
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    if ([fileManager fileExistsAtPath:filePath]==YES) {
        NSLog(@"File exists");
        return YES;
    }
    return NO;
}













//+ (void) downloadFileByUrl: (NSString *) urlStr {
//
//    //1.创建会话管理者
//    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    /*
//     第一个参数:请求对象
//     第二个参数:progress 进度回调 downloadProgress
//     第三个参数:destination 回调(目标位置)
//     有返回值
//     targetPath:临时文件路径
//     response:响应头信息
//     第四个参数:completionHandler 下载完成之后的回调
//     filePath:最终的文件路径
//     */
//    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        //监听下载进度
//        //completedUnitCount 已经下载的数据大小
//        //totalUnitCount     文件数据的中大小
//        NSLog(@"%f",1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
//
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
//        NSLog(@"targetPath:%@",targetPath);
//        NSLog(@"fullPath:%@",fullPath);
//        return [NSURL fileURLWithPath:fullPath];
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        NSLog(@"%@",filePath);
//        
//    }];
//    
//    
//    
//    //3.执行Task
//    
//    [download resume];
//    
//}

//    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"iconfont2.ttf"];
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
//    [operation setCompletionBlock:^{
//        NSLog(@"downloadComplete!");
//        NSString *path;
//        path = filePath;
//        NSString *data = [self readFile: path];
//        NSLog(@"%@",data);
//    }];
//    ]
//    [operation start];
//}
//+ (NSString *)readFile:(NSString *)fileName
//
//{
//    NSLog(@"readFile");
//
//    NSString *appFile = fileName;
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:appFile])
//    {
//        NSError *error= NULL;
//        NSString *resultData = [NSString stringWithContentsOfFile: appFile encoding: NSUTF8StringEncoding error: &error];
//        if (error == NULL)
//            return resultData;
//    }
//    return NULL;
//}

@end
