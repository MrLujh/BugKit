//
//  THTerminalInfo.h
//  TaiHealthy
//
//  Created by guagua on 17/3/24.
//  Copyright © 2017年 taiKang. All rights reserved.
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

@interface TLTerminalInfo : NSObject

@property (nonatomic,copy) NSString *appVersion;
@property (nonatomic,copy) NSString *deviceId;
@property (nonatomic,copy) NSString *mobileBrand;
@property (nonatomic,copy) NSString *mobileType;
@property (nonatomic,copy) NSString *systemVersion;
@property (nonatomic,copy) NSString *terminalType;

+ (instancetype)sharedTerminalInfo;

@end
