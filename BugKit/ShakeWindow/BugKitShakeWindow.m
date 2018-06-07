//
//  BugKitShakeWindow.m
//  BugKitExample
//
//  Created by lujh on 2018/3/20.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitShakeWindow.h"
#import "BugKitListTableViewController.h"
@implementation BugKitShakeWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        
        BugKitListTableViewController *vc = [[BugKitListTableViewController alloc] init];
        UINavigationController *navigator=[[UINavigationController alloc] initWithRootViewController:vc];
        [self.rootViewController presentViewController:navigator animated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShakeKeyWindow" object:nil];
    }
}

@end
