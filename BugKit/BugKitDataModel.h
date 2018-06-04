//
//  BugKitDataModel.h
//  BugKitExample
//
//  Created by lujh on 2018/6/4.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BugKitDataModel : NSObject
+(instancetype)sharedInstance;
/**蒲公英注册appKey*/
@property (nonatomic,strong)NSString *pgyAppKey;
/**蒲公英注册apiKey*/
@property (nonatomic,strong)NSString *pgyApiKey;
/**蒲公英历史版本链接*/
@property (nonatomic,strong)NSString *historyUrl;
/**网络通知*/
@property (nonatomic,strong)NSString *notificationName;
/**网络基础信息*/
@property (nonatomic,strong)NSArray *baseNetArray;

/**
 *  @method  getPGYInfomationDict
 *  @discribtion 获取蒲公英相关信息字典： "appKey":"蒲公英平台注册appKey"  "openUrl"蒲公英历史版本链接
 */
-(NSDictionary *)getPGYInfomationDict;
@end
