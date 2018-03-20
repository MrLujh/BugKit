//
//  LujhBaseUrlManager.h
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kEnvHostURLChangeNotificationName @"kEnvHostURLChangeNotificationName"

@interface LujhBaseUrlManager : NSObject<NSCoding>

+(instancetype)sharedInstance;
/** 基础IP */
@property (nonatomic,copy) NSString *hostBaseURL;
@end
