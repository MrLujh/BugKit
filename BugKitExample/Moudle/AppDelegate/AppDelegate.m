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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  打开数据库（地区表）
     */
    
    [self initThirdService];
    
    // 设置根控制器
    [self selectRootController];

    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark -设置根控制器

- (void)selectRootController
{
    TLTabBarViewController *tabBarVC = [[TLTabBarViewController alloc]init];
    self.tabBarVC = tabBarVC;
    self.window.rootViewController = tabBarVC;
}

@end
