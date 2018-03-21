//
//  LujhNetWorkManager.m
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "LujhNetWorkManager.h"
#import "PhoneInformation.h"
#import "AppDelegate.h"
#import  <sys/socket.h>
#import  <sys/sockio.h>
#import  <sys/ioctl.h>
#import  <net/if.h>
#import  <arpa/inet.h>
#import "LujhBaseUrlManager.h"

#define NetWorkErrorMessage  @"请检查网络后重试！"

@interface LujhNetWorkManager()

@property (nonatomic,copy) NSMutableDictionary *terminalInfoDic;
@property (strong, nonatomic) NSURL *changeUrl;

@property (assign, nonatomic) NSInteger first;
@end

@implementation LujhNetWorkManager

static LujhNetWorkManager *manager = nil;

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseUrl = [LujhBaseUrlManager sharedInstance].hostBaseURL;
        [self createNetworkManagerWithBaseUrl:baseUrl];
    });
    
    return manager;
}

+ (void)createNetworkManagerWithBaseUrl:(NSString *)baseUrl {
    
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    manager = [[LujhNetWorkManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    PhoneInformation *terminalInfo = [PhoneInformation sharedTerminalInfo];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:terminalInfo.appVersion forKey:@"appVersion"];
    [dic setValue:terminalInfo.deviceId forKey:@"deviceId"];
    [dic setValue:terminalInfo.mobileBrand forKey:@"mobileBrand"];
    [dic setValue:terminalInfo.mobileType forKey:@"mobileType"];
    [dic setValue:terminalInfo.systemVersion forKey:@"systemVersion"];
    [dic setValue:@"IOS" forKey:@"terminalType"];
    manager.terminalInfoDic = dic;
    
    
    manager.requestSerializer.timeoutInterval = 3 * 60.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(changeBaseUrl:) name:kEnvHostURLChangeNotificationName object:nil];
}

- (void)changeBaseUrl:(NSNotification *)notification {
    NSString *baseUrl = [LujhBaseUrlManager sharedInstance].hostBaseURL;
    
    if (![baseUrl isEqualToString:manager.baseURL.absoluteString]) {
        if (![baseUrl hasSuffix:@"/"]) {
            baseUrl = [baseUrl stringByAppendingString:@"/"];
        }
        self.changeUrl = [NSURL URLWithString:baseUrl];
    } else {
        self.changeUrl = nil;
    }
}

- (NSURL *)baseURL {
    if (self.changeUrl) {
        return self.changeUrl;
    }
    
    return [super baseURL];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger code = [dict[@"code"] integerValue];
        
        if (success) {
            success(task, responseObject);
        }
    } failure:failure];
}

#pragma mark:基本方法
- (void)getUrlString:(NSString *)url
           withParam:(id)param
    withSuccessBlock:(successBlock)success
    withFailureBlock:(failureBlock)failure{
    [self getUrlString:url withParam:param withProgressBlock:nil withSuccessBlock:success withFailureBlock:failure];
}
- (void)getUrlString:(NSString *)url
           withParam:(id)param
   withProgressBlock:(progressBlock)progress
    withSuccessBlock:(successBlock)success
    withFailureBlock:(failureBlock)failure{
    
    
    [self GET:url parameters:param progress:progress success:^(NSURLSessionDataTask *task,id responseObject) {
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        failure(error);
        
    }];
}
- (void)postUrlString:(NSString *)url
            withParam:(id)param
     withSuccessBlock:(successBlock)success
     withFailureBlock:(failureBlock)failure{
    [self postUrlString:url withParam:param withProgressBlock:nil withSuccessBlock:success withFailureBlock:failure];
}

- (void)postUrlString:(NSString *)url
            withParam:(id)param
    withProgressBlock:(progressBlock)progress
     withSuccessBlock:(successBlock)success
     withFailureBlock:(failureBlock)failure{
    
    [self POST:url parameters:param progress:progress success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
        
    }];
}

- (void)deleteUrlString:(NSString *)url
              withParam:(id)param
       withSuccessBlock:(successBlock)success
       withFailureBlock:(failureBlock)failure{
    
    
    [self DELETE:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

- (void)putUrlString:(NSString *)url
           withParam:(id)param
    withSuccessBlock:(successBlock)success
    withFailureBlock:(failureBlock)failure{
    
    [self PUT:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}
-(void)requestHostWithUrlString:(NSString *)url method:(TLNetWorkMethod)method withParm:(id)parm withSuccessBlock:(successBlock)success
               withFailureBlock:(failureBlock)failure{
    [self requestHostWithUrlString:url method:method withParm:parm withProgressBlock:nil withSuccessBlock:success withFailureBlock:failure];
}
-(void)requestHostWithUrlString:(NSString *)url method:(TLNetWorkMethod)method withParm:(id)parm withProgressBlock:(progressBlock)progress withSuccessBlock:(successBlock)success
               withFailureBlock:(failureBlock)failure{
    
    if (parm==nil || [parm isKindOfClass:[NSDictionary class]]) {
        
    }else{
        NSLog(@"(参数格式错误) url:%@",url);
        return;
    }
    
    PhoneInformation *terminalInfo = [PhoneInformation sharedTerminalInfo];
    NSString * appVersion = terminalInfo.appVersion;
    NSString * deviceId = terminalInfo.deviceId;
    NSString * deviceVersion = terminalInfo.systemVersion;
    NSString * deviceModel = terminalInfo.mobileType;
    NSString * deviceM = [deviceModel stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * urlWithDeviceInfo = [NSString stringWithFormat:@"%@?deviceId=%@&deviceType=2&deviceVersion=%@&appVersion=%@&deviceModel=%@",url,deviceId,deviceVersion,appVersion,deviceM];
    
    
    switch (method) {
        case TLNetWorkMethodGet:
        {
            [self getUrlString:url withParam:parm withProgressBlock:progress withSuccessBlock:success withFailureBlock:failure];
        }
            break;
        case TLNetWorkMethodPost:
        {
            
            [self postUrlString:urlWithDeviceInfo withParam:parm withProgressBlock:progress withSuccessBlock:success withFailureBlock:failure];
            
        }
            break;
        case TLNetWorkMethodPut:
        {
            [self putUrlString:urlWithDeviceInfo withParam:parm withSuccessBlock:success withFailureBlock:failure];
        }
            break;
        case TLNetWorkMethodDelete:
        {
            [self deleteUrlString:urlWithDeviceInfo withParam:parm withSuccessBlock:success withFailureBlock:failure];
            
        }
            break;
        default:
        {
            [self getUrlString:urlWithDeviceInfo withParam:parm withProgressBlock:progress withSuccessBlock:success withFailureBlock:failure];
            
        }
            break;
    }
}

- (void)testBaseUrlWithDic:(NSMutableDictionary *)dic SuccessBlock:(successBlock)success failureBlock:(failureBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@",self.baseURL];
    
    [self requestHostWithUrlString:url method:TLNetWorkMethodGet withParm:dic withSuccessBlock:success withFailureBlock:failure];
}

@end
