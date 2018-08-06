//
//  DTSkinChangeViewController.m
//  DTSkinChange
//
//  Created by 729020128@qq.com on 08/06/2018.
//  Copyright (c) 2018 729020128@qq.com. All rights reserved.
//

#import "DTSkinChangeViewController.h"
#import "NetWorkHelper.h"
#import "ThemeManager.h"
#import "UIView+ThemeChange.h"
#import "TBCityIconInfo.h"
#import "TBCityIconFont.h"

@interface DTSkinChangeViewController ()
/** 点击 下载主题1 */
@property (nonatomic, strong) UIButton *downloadTheme1;
/** 点击 下载主题2 */
@property (nonatomic, strong) UIButton *downloadTheme2;
/** 显示按钮 */
@property (nonatomic, strong) UIButton *showButton;
/** 显示按钮 */
@property (nonatomic, strong) UILabel   *showLabel;
/** 换肤manager */
@property (nonatomic, strong) ThemeManager *themeManager;
/** 错误显示按钮 */
@property (nonatomic, strong) UIButton *wrongShowButton;
    
@end

@implementation DTSkinChangeViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initParameters];
    [self setUpUI];
    [self downloadUrl];
}
    
- (void) initParameters {
    self.themeManager = [ThemeManager shareManager];
}
    
- (void) setUpUI {
    [self.view addSubview:self.downloadTheme1];
    [self.view addSubview:self.downloadTheme2];
    [self.view addSubview:self.showLabel];
    [self.view addSubview:self.showButton];
    [self.view addSubview:self.wrongShowButton];
    
    self.downloadTheme1.frame = CGRectMake( 20, 100, 100, 40);
    self.downloadTheme2.frame = CGRectMake( 200, 100, 100, 40);
    self.showLabel.frame      = CGRectMake( 20, 200, 100, 40);
    self.showButton.frame     = CGRectMake( 200, 200, 100, 40);
    self.wrongShowButton.frame = CGRectMake(200, 280, 100, 40);
}
#pragma mark - private methods
    /** 下载文件 */
- (void) downloadUrl {
    NSString *urlStr = @"http://zhuzq.top/myresources/ThemeType1.plist";
    NSString *savaName = @"ThemeType1";
    NSString *themeType = [self.themeManager.themeType isEqualToString:ThemeTypeDefault] ? savaName : ThemeTypeDefault;
    [self.themeManager downloadAndChangeThemeWithUrl:urlStr AndSaveName:themeType];
}
    
    /** 这里是淘点点的框架中，未对UniCode 进行处理的 */
- (UIImage *) wrongMethodsIconWithInfo:(TBCityIconInfo *)info fontName: (NSString *)fontName {
    CGFloat size = info.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat realSize = size * scale;
    UIColor *color = info.color ? info.color : [[ThemeManager shareManager] colorWithColorType:themeMainColor];
    UIFont *font = [TBCityIconFont fontWithSize:realSize fontName:fontName];
    UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ([info.text respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        /**
         * 如果这里抛出异常，请打开断点列表，右击All Exceptions -> Edit Breakpoint -> All修改为Objective-C
         * See: http://stackoverflow.com/questions/1163981/how-to-add-a-breakpoint-to-objc-exception-throw/14767076#14767076
         */
        [info.text drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: color}];
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextSetFillColorWithColor(context, color.CGColor);
        [info.text drawAtPoint:CGPointMake(0, 0) withFont:font];
#pragma clang pop
    }
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
}
    
#pragma mark - getter &&setter
    
- (UIButton *)downloadTheme1 {
    if (_downloadTheme1 == nil) {
        UIButton *btn = [UIButton new];
        btn.themeType_color = themeMainColor;
        [btn setTitle:@"下载主题1" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(downloadUrl) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor  = [UIColor greenColor];
        _downloadTheme1 = btn;
    }
    return _downloadTheme1;
}
    
- (UIButton *)downloadTheme2 {
    if (_downloadTheme2 == nil) {
        UIButton *btn = [UIButton new];
        btn.themeType_color = themeMainColor;
        [btn setTitle:@"下载主题2" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(downloadUrl) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor  = [UIColor greenColor];
        
        _downloadTheme2 = btn;
    }
    return _downloadTheme2;
}
    
- (UIButton *)showButton {
    if (_showButton == nil) {
        UIButton *btn = [UIButton new];
        /** 设置图片 */
        btn.themeType_image = image_Btn1;
        [btn setTitle:@"显示btn" forState:0];
        btn.backgroundColor  = [UIColor greenColor];
        
        _showButton = btn;
    }
    return _showButton;
}
    
- (UILabel *)showLabel {
    if (_showLabel == nil) {
        UILabel *lbl = [UILabel new];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = @"显示Label";
        lbl.themeType_color = themeMainColor;
        lbl.backgroundColor  = [UIColor greenColor];
        
        _showLabel = lbl;
    }
    return _showLabel;
}
    
- (UIButton *)wrongShowButton {
    if (_wrongShowButton == nil) {
        UIButton *btn = [UIButton new];
        [btn setTitle:@"错误btn" forState:0];
        NSString *unicodeStr = _themeManager.themeDic[image_Btn2];
        NSLog(@"\n🌶🌶🌶\n错误的UniCodeStr： \n%@\n🌶🌶🌶",unicodeStr);
        TBCityIconInfo *info = [TBCityIconInfo iconInfoWithText:unicodeStr
                                                           size:20
                                                          color:[UIColor redColor]];
        UIImage *img = [self wrongMethodsIconWithInfo: info fontName:nil];
        [btn setImage:img forState:UIControlStateNormal];
        btn.backgroundColor  = [UIColor greenColor];
        _wrongShowButton = btn;
    }
    return _wrongShowButton;
}
    
    
    @end
