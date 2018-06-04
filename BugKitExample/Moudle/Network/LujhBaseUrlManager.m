//
//  LujhBaseUrlManager.m
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "LujhBaseUrlManager.h"
#import "LujhNetWorkManager.h"

// 宏设置默认环境Host..
#if (DEVELOP==1)
// Debug
#define DEFAULT_URL_HOST @"https://119.120.88.640"

#else
// Release
#define DEFAULT_URL_HOST @"https://lujh.com"

#endif
@implementation LujhBaseUrlManager
+(instancetype)sharedInstance{
    
    static  LujhBaseUrlManager *baseUrlManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseUrlManager = [[LujhBaseUrlManager alloc] init];
    });
    return baseUrlManager;
}

- (NSString *)hostBaseURL {
    
     return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"hostUrl"] >0?(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"hostUrl"] : DEFAULT_URL_HOST;
}

@end
