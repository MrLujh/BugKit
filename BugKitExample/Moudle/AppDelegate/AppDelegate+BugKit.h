//
//  AppDelegate+BugKit.h
//  BugKitExample
//
//  Created by lujh on 2018/6/4.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "AppDelegate.h"

@class BugKitAPMWindow;

@interface AppDelegate (BugKit)

@property (nonatomic,copy) BugKitAPMWindow *apmWindow;
// 摇一摇初始化Window
-(void)initShakeWindow;
@end
