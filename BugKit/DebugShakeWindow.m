//
//  DebugShakeWindow.m
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "DebugShakeWindow.h"
#import "DebugListTableViewController.h"

@implementation DebugShakeWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    }
    return self;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        DebugListTableViewController *vc = [[DebugListTableViewController alloc] init];
        UINavigationController *navigator=[[UINavigationController alloc] initWithRootViewController:vc];
        [self.rootViewController presentViewController:navigator animated:YES completion:nil];
    }
}

@end
