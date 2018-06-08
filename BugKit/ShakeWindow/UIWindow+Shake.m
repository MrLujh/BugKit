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
        
        BugKitListTableViewController *vc = [[BugKitListTableViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.rootViewController presentViewController:nav animated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kShowAPMWindowNotification" object:nil userInfo:nil];
    }
}

@end
