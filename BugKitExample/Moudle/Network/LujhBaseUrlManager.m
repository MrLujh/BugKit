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
#if (TAILIFE_DEVELOP==1)
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
        baseUrlManager = [LujhBaseUrlManager getCurrentEnvObjFormUserDefault];
    });
    return baseUrlManager;
}

+ (instancetype)getCurrentEnvObjFormUserDefault {
    
    LujhBaseUrlManager *envDefault = [[LujhBaseUrlManager alloc] init];
    NSString*resourcePath =[[NSBundle mainBundle] pathForResource:@"config.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:resourcePath];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [json objectForKey:@"host"];
    NSMutableArray *muArr = arr.mutableCopy;
    NSMutableDictionary *dic = ((NSDictionary *)muArr[0]).mutableCopy;
    [dic setObject:DEFAULT_URL_HOST forKey:@"url"];
    muArr[0] = dic;
    
    
    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionaryWithDictionary:json];
    [dataDictionary setObject:muArr forKey:@"host"];
    
    NSData *jdata = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONReadingAllowFragments error:nil];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"config.json"];
    [jdata writeToFile:filePath atomically:YES];
    return envDefault;
    
}

- (NSString *)hostBaseURL {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"config.json"];
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePatch];
    id json = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [json objectForKey:@"host"];
    return arr[0][@"url"];
}

@end
