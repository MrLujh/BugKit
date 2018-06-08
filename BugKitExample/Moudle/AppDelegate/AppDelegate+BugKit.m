//
//  AppDelegate+BugKit.m
//  BugKitExample
//
//  Created by lujh on 2018/6/4.
//  Copyright © 2018年 lujh. All rights reserved.
//
#ifdef DEVELOP
#import "Bugkit.h"
#else

#endif

#import "AppDelegate+BugKit.h"
#import <objc/runtime.h>

@implementation AppDelegate (BugKit)

- (BugKitAPMWindow *)apmWindow
{
    BugKitAPMWindow *_apmWindow = objc_getAssociatedObject(self, _cmd);
    if (!_apmWindow) {
        
        objc_setAssociatedObject(self, _cmd, _apmWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _apmWindow;
}

- (void)setApmWindow:(BugKitAPMWindow *)apmWindow
{
  objc_setAssociatedObject(self, @selector(apmWindow), apmWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)initShakeWindow
{
#ifdef DEVELOP
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    Class class1 = NSClassFromString(@"BugKitAPMWindow");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.apmWindow =   [[class1 alloc] initWithFrame:CGRectMake(0, 200, 60, 60)];
    });
    
    
    // 项目基础API配置设置
    [BugKitBaseUrlManager registerNetWorkBaseNetInfo:@[@{
                                                           @"name":@"当前环境",
                                                           @"type":@"hostBaseTypeNow",
                                                           @"url":@"https://119.120.88.640"
                                                           },
                                                       @{
                                                           @"name":@"测试环境",
                                                           @"type":@"hostBaseTypeTest",
                                                           @"url":@"https://119.120.88.640"
                                                           },
                                                       @{
                                                           @"name":@"生产环境",
                                                           @"type":@"hostBaseTypeProduct",
                                                           @"url":@"https://lujh.com"
                                                           },
                                                       @{
                                                           @"name":@"类环境",
                                                           @"type":@"hostBaseTypeStaging",
                                                           @"url":@""
                                                           },
                                                       @{
                                                           @"name":@"个人环境",
                                                           @"type":@"hostBaseTypePersonal",
                                                           @"url":@""
                                                           }
                                                       ] changeNotificationName:@"kEnvHostURLChangeNotificationName"];
    
    // 蒲公英API设置
    [BugKitBaseUrlManager sessionStartWithPGYAppKey:@"332ada3b2e4c856c09acc9796cfc9099" APIKey:@"1303c11160b475cc56b9d5df820a17ed" historyUrl:@"https://www.pgyer.com/m6X7"];
#else
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
#endif
}
@end
