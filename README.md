# DTSkinChange
*随着公司组件化的发展，又提出了一个新的需求，emmm.... 增加一个一键换肤功能吧，就和网易云音乐一样，当时我的表情是这样的，*
闲话不多说直接开搞吧
* 总结构
![总结构.png](https://upload-images.jianshu.io/upload_images/5712798-fb82a58adf3ba5c5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 一、换肤框架部分
首先新建的一个manager类来管理，这个应该没有什么问题，主要思想就是：
1. 在对manager类的themeType设置后获取相应本地下载后的配置文件，从而进行读取配置文件，
2. hook了几个主要显示UI的类，用通知的方式通知进行显示UI，这里只通知设置了配置文件类型的View。
3. View子类的颜色，或者图片名，通过ConstString的宏定义设置，而不是直接设置颜色
* .m文件
```
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
```
* .h文件中主要的2个方法：
```
/** 根据类型返回相应颜色 */
- (UIColor *)colorWithColorType:(NSString *)colorTypeStr;
/** 根据类型返回相应图片 */
- (UIImage *)imageWithImageType:(NSString *)imageTypeStr;
```
* View子类的hook
主要提及这个思想(文末会讲到借鉴的谁的): 通过PerformSelector存下selector方法来改变颜色或者设置图片，使用hook而不存下View手动设置，一个原因是太low,二个主要是为了减少View的持有，因为这个manager是个单例
```
- (void) updateTheme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id obj, BOOL * _Nonnull stop) {
        SEL selector = NSSelectorFromString(key);
        [UIView animateWithDuration:0.3 animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:obj];
#pragma clang diagnostic pop
        }];
    }];
}
```
然后举个栗子：UIlabel的category中，在hook的时候存下相应的selector方法，用于之后的Perform selector，这里在set方法中重绘制了一次，目的是为了设置完themeType_Color后，调用一次原生setter方法，代码中就不需要设置完类型后还要设置一次textColor，有疑惑的可以注掉这一段试试效果
```
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTextColor:) swappedMethod:@selector(dt_setTextColor:)];
    });
}

- (void)dt_setTextColor:(UIColor *)color {
    UIColor *textColor = [[ThemeManager shareManager] colorWithColorType:self.themeType_color];
    if (textColor) {
        [self dt_setTextColor:textColor];
        [self.pickers setObject:textColor forKey:@"setTextColor:"];
    } else {
        [self dt_setTextColor:color];
    }
}

- (void)setThemeType_color:(NSString *)themeType_color {
    [super setThemeType_color:themeType_color];
    
    UIColor *textColor = [[ThemeManager shareManager] colorWithColorType:themeType_color];
    [self setTextColor:textColor];
}
```  
## 二、iconfont部分 
*这里需要重重重点关注的是：使用iconfont如果你直接根据iconfont官网补上 \U 加0保证8位，会出现一个问题，如：读取配置的时候，“\U0000e6e6”在转成string后，会变成"\\U0000e6e6"，so,显示不了
* 错误栗子
```
        UIButton *btn = [UIButton new];
        [btn setTitle:@"错误btn" forState:0];
        NSString *unicodeStr = _themeManager.themeDic[image_Btn2];
        NSLog(@"\n🌶🌶🌶\n错误的UniCodeStr： \n%@\n🌶🌶🌶",unicodeStr);
        TBCityIconInfo *info = [TBCityIconInfo iconInfoWithText:unicodeStr
                                                           size:20
                                                          color:[UIColor redColor]];
        UIImage *img = [self wrongMethodsIconWithInfo: info fontName:nil];
        [btn setImage:img forState:UIControlStateNormal];
//打印日志：
🌶🌶🌶
错误的UniCodeStr： 
\U0000e65f
🌶🌶🌶
```  
* 解决方案：且可以直接就用后四位，不用加 \U和补0  
```
    NSString *tempStr1 = [@"\\U" stringByAppendingString:uniCodeStr];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
```
## 三、文件流下载方法
目前项目还是用的AFN2.0,所以给了一个AFN2.0的AFHTTPRequestOperation 下载方法，3.0的方法也在.m文件后有(注释的)，具体方法在```NetWorkHelper.m ```中

[Demo下载地址](https://github.com/zzqhd/DTSkinChange.git)
