//
//  BugKitDataModel.m
//  BugKitExample
//
//  Created by lujh on 2018/6/4.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitDataModel.h"

@implementation BugKitDataModel

+(instancetype)sharedInstance;
{
    static BugKitDataModel *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    return sharedManager;
}


/**
 *  @method  getPGYInfomationDict
 *  @discribtion 获取蒲公英相关信息字典： "appKey":"蒲公英平台注册appKey"  "openUrl"蒲公英历史版本链接
 */
-(NSDictionary *)getPGYInfomationDict;
{
    return @{@"appKey":self.pgyAppKey,@"apiKey":self.pgyApiKey,@"openUrl":self.historyUrl};
}
@end
