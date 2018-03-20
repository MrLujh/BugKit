//
//  LujhNetWorkManager.h
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^successBlock)(id _Nullable responseObject,BOOL isSuccess,NSString * _Nullable msg);
typedef void (^failureBlock)(NSError * _Nullable error);
typedef void (^progressBlock)(NSProgress * _Nullable progress);

/*网络请求方式 */
typedef NS_ENUM(NSInteger, TLNetWorkMethod) {
    TLNetWorkMethodGet,//默认从0开始get请求
    TLNetWorkMethodPost,//post请求
    TLNetWorkMethodPut,//put请求
    TLNetWorkMethodDelete,//delete请求
};


@interface LujhNetWorkManager : AFHTTPSessionManager

+ (LujhNetWorkManager *_Nullable)sharedManager;

#pragma mark:主方法
-(void)requestHostWithUrlString:(NSString *_Nullable)url method:(TLNetWorkMethod)method withParm:(NSDictionary*_Nullable)parm withSuccessBlock:(successBlock _Nonnull )success
               withFailureBlock:(failureBlock _Nullable )failure;

- (void)testBaseUrlWithDic:(NSMutableDictionary *_Nullable)dic SuccessBlock:(successBlock _Nullable )success failureBlock:(failureBlock _Nonnull )failure;
@end
