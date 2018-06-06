//
//  BugKitBaseUrlManager.h
//  BugKitExample
//
//  Created by lujh on 2018/6/4.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for DebugKit.
FOUNDATION_EXPORT double DebugKitVersionNumber;

//! Project version string for DebugKit.
FOUNDATION_EXPORT const unsigned char DebugKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DebugKit/PublicHeader.h>
@interface BugKitBaseUrlManager : NSObject
/**
 *  @method  sessionStartWithPGYKey:historyUrl:
 *  @discribtion 开启蒲公英功能
 *  @param  appKey 蒲公英平台注册appKey
 *  @param  apiKey 蒲公英平台注册APIKey
 *  @param  historyUrl 蒲公英历史版本链接
 */
+(void)sessionStartWithPGYAppKey:(NSString *)appKey APIKey:(NSString*)apiKey historyUrl:(NSString *)historyUrl;
/**
 *  @method  registerNetWorkBaseNetInfo:changeNotificationName:
 *  @discribtion 注册网络基本信息和网络变环境变更通知。DebugKit会在手动切换网络环境时，发出通知。接收注册的通知可在通知object属性中。获得当前的网络信息
 
 *  @param  baseNetInfo  网络基础信息数组（网络基础信息数组格式见方法下面的注释）
 *  @param  notificationName  通知注册名称
 */
+(void)registerNetWorkBaseNetInfo:(NSArray *)baseNetInfo changeNotificationName:(NSString *)notificationName;
/*
 网络基础信息数组格式如下，其中："当前环境" 为最终生效的网络环境
 可根据需要扩展更多环境
 [
 {
 "name":"当前环境",
 "type":"hostBaseTypeNow",
 "url":""
 },
 {
 "name":"测试环境",
 "type":"hostBaseTypeTest",
 "url":"http://110.250.11.220"
 },
 {
 "name":"生产环境",
 "type":"hostBaseTypeProduct",
 "url":"https://xxxxxx.xxxx.xxx"
 },
 {
 "name":"类环境",
 "type":"hostBaseTypeStaging",
 "url":""
 },
 {
 "name":"个人环境",
 "type":"hostBaseTypePersonal",
 "url":""
 }
 ],
 */
@end
