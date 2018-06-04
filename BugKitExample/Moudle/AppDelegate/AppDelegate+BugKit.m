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

@implementation AppDelegate (BugKit)

-(void)initShakeWindow
{
#ifdef DEVELOP
    Class class = NSClassFromString(@"BugKitShakeWindow");
    self.window = [[class alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
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
    
    [BugKitBaseUrlManager sessionStartWithPGYAppKey:@"332ada3b2e4c856c09acc9796cfc9099" APIKey:@"1303c11160b475cc56b9d5df820a17ed" historyUrl:@"https://www.pgyer.com/m6X7"];
#else
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
#endif
}
@end
