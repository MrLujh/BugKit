//
//  UIWindow+Shake.m
//  BugKitExample
//
//  Created by lujh on 2018/6/8.
//  Copyright © 2018年 lujh. All rights reserved.
//

#define CZVersionKey @"algjalgja"
#import "UIWindow+Shake.h"
#import "BugKitListTableViewController.h"

@implementation UIWindow (Shake)
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        
        NSString *stre = [[NSUserDefaults standardUserDefaults] objectForKey:@"count"];
        if ([stre isEqualToString:@"1"]) {
            // 隐藏
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kDismissListVCNotification" object:nil];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"count"];
        }else {
            
            // 显示
            BugKitListTableViewController *vc = [[BugKitListTableViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.rootViewController presentViewController:nav animated:YES completion:nil];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"count"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShakeKeyWindow" object:nil];
    }
}

@end
