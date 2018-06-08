//
//  AppDelegate.m
//  TaiLife
//
//  Created by wyl on 2017/8/17.
//  Copyright © 2017年 TaiKang. All rights reserved.
//

#import "AppDelegate.h"
#import "TLTabBarViewController.h"
#import "AppDelegate+ThirdService.h"
#import "AppDelegate+BugKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  打开数据库（地区表）
     */
    
    // 设置根控制器
    [self selectRootController];
    
    // 第三方服务初始化
    [self initThirdService];
    
    // 摇一摇初始化Window
    [self initShakeWindow];

    return YES;
}

#pragma mark -设置根控制器

- (void)selectRootController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TLTabBarViewController *tabBarVC = [[TLTabBarViewController alloc]init];
    self.window.rootViewController = tabBarVC;
    
    [self.window makeKeyAndVisible];
}

@end
