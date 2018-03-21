//
//  PhoneInformation.h
//  BugKitExample
//
//  Created by lujh on 2018/3/21.
//  Copyright © 2018年 lujh. All rights reserved.
//
//终端信息
/*
 appVersion (string): APP版本 ,
 deviceId (string, optional): 设备id ,
 mobileBrand (string): 手机品牌 ,
 mobileType (string): 手机型号 ,
 systemVersion (string): 系统版本 ,
 terminalType (string): iOS/ANDROID
 */
#import <Foundation/Foundation.h>

@interface PhoneInformation : NSObject
@property (nonatomic,copy) NSString *appVersion;
@property (nonatomic,copy) NSString *deviceId;
@property (nonatomic,copy) NSString *mobileBrand;
@property (nonatomic,copy) NSString *mobileType;
@property (nonatomic,copy) NSString *systemVersion;
@property (nonatomic,copy) NSString *terminalType;

+ (instancetype)sharedTerminalInfo;
@end
