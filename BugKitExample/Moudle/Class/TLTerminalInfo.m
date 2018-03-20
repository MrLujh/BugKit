//
//  THTerminalInfo.m
//  TaiHealthy
//
//  Created by guagua on 17/3/24.
//  Copyright © 2017年 taiKang. All rights reserved.
//

#import "TLTerminalInfo.h"
#import "sys/utsname.h"
#import "LujhNetWorkManager.h"

@implementation TLTerminalInfo

+ (instancetype)sharedTerminalInfo{
    
    static TLTerminalInfo *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TLTerminalInfo alloc] init];
        [instance setTerminalInfo];
    });
    return instance;
}

- (void)setTerminalInfo{

    _deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    _deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    _mobileType =  [self deviceVersion];
    _systemVersion = [[UIDevice currentDevice] systemVersion];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    _appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = info.subscriberCellularProvider;
    _terminalType = @"iOS";
    _mobileBrand= @"iPhone";
    NSLog(@"%@--%@--%@--%@",_deviceId,_mobileType,_systemVersion,_appVersion);
}

- (NSString*)deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,Ω2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if([deviceString isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    
    if([deviceString isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    
    if([deviceString isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    
    if([deviceString isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([deviceString isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([deviceString isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([deviceString isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([deviceString isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([deviceString isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([deviceString isEqualToString:@"iPod1,1"]) return@"iPod Touch 1G";
    
    if([deviceString isEqualToString:@"iPod2,1"]) return@"iPod Touch 2G";
    
    if([deviceString isEqualToString:@"iPod3,1"]) return@"iPod Touch 3G";
    
    if([deviceString isEqualToString:@"iPod4,1"]) return@"iPod Touch 4G";
    
    if([deviceString isEqualToString:@"iPod5,1"]) return@"iPod Touch 5G";
    
    if([deviceString isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    
    if([deviceString isEqualToString:@"iPad2,1"]) return@"iPad 2";
    
    if([deviceString isEqualToString:@"iPad2,2"]) return@"iPad 2";
    
    if([deviceString isEqualToString:@"iPad2,3"]) return@"iPad 2";
    
    if([deviceString isEqualToString:@"iPad2,4"]) return@"iPad 2";
    
    if([deviceString isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    
    if([deviceString isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    
    if([deviceString isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    
    if([deviceString isEqualToString:@"iPad3,1"]) return@"iPad 3";
    
    if([deviceString isEqualToString:@"iPad3,2"]) return@"iPad 3";
    
    if([deviceString isEqualToString:@"iPad3,3"]) return@"iPad 3";
    
    if([deviceString isEqualToString:@"iPad3,4"]) return@"iPad 4";
    
    if([deviceString isEqualToString:@"iPad3,5"]) return@"iPad 4";
    
    if([deviceString isEqualToString:@"iPad3,6"]) return@"iPad 4";
    
    if([deviceString isEqualToString:@"iPad4,1"]) return@"iPad Air";
    
    if([deviceString isEqualToString:@"iPad4,2"]) return@"iPad Air";
    
    if([deviceString isEqualToString:@"iPad4,3"]) return@"iPad Air";
    
    if([deviceString isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    
    if([deviceString isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    
    if([deviceString isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    
    if([deviceString isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    
    if([deviceString isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    
    if([deviceString isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    
    if([deviceString isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    
    if([deviceString isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    
    if([deviceString isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    
    if([deviceString isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    
    if([deviceString isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    
    if([deviceString isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    
    if([deviceString isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    
    if([deviceString isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";
    
    if([deviceString isEqualToString:@"i386"]) return@"iPhone Simulator";
    
    if([deviceString isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    
    
    return deviceString;
}


@end
