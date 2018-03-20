//
//  AppDelegate+ThirdService.m
//  TaiLife
//
//  Created by zhanglin on 2017/12/19.
//  Copyright © 2017年 TaiKang. All rights reserved.
//

#import "AppDelegate+ThirdService.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation AppDelegate (ThirdService)

-(void)initThirdService
{
    // setup log system
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    [self initShakeWindow];
}

-(void)initShakeWindow
{
    Class class = NSClassFromString(@"BugKitShakeWindow");
    self.window = [[class alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
