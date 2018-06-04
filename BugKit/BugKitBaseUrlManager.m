//
//  BugKitBaseUrlManager.m
//  BugKitExample
//
//  Created by lujh on 2018/6/4.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitBaseUrlManager.h"
#import "BugKitDataModel.h"
@implementation BugKitBaseUrlManager
#pragma mark Public
+(void)sessionStartWithPGYAppKey:(NSString *)appKey APIKey:(NSString*)apiKey historyUrl:(NSString *)historyUrl;
{
    BugKitDataModel *dataModel =  [BugKitDataModel sharedInstance];
    dataModel.pgyAppKey = appKey;
    dataModel.pgyApiKey = apiKey;
    dataModel.historyUrl = historyUrl;
}

+(void)registerNetWorkBaseNetInfo:(NSArray *)baseNetInfo changeNotificationName:(NSString *)notificationName;
{
    BugKitDataModel *dataModel =  [BugKitDataModel sharedInstance];
    dataModel.notificationName = notificationName;
    dataModel.baseNetArray = [NSArray arrayWithArray:baseNetInfo];
}

@end
