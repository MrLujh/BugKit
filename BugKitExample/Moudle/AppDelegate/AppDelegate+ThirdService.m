//
//  AppDelegate+ThirdService.m
//  TaiLife
//
//  Created by zhanglin on 2017/12/19.
//  Copyright © 2017年 TaiKang. All rights reserved.
//

#import "AppDelegate+ThirdService.h"

@implementation AppDelegate (ThirdService)

-(void)initThirdService
{
    
    [self initShakeWindow];
}

-(void)initShakeWindow
{
    Class class = NSClassFromString(@"BugKitShakeWindow");
    self.window = [[class alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
