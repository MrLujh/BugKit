# ☆☆☆ “BugKit” ☆☆☆

### 支持pod导入

* pod 'BugKit','~> 3.0.2'

* 执行pod search BugKit提示搜索不到，可以执行以下命令更新本地search_index.json文件
  
```objc 
rm ~/Library/Caches/CocoaPods/search_index.json
```
* 如果pod search还是搜索不到，执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了

* ![Mou icon](https://github.com/MrLujh/BugKit/blob/master/BugKit.gif)

### 项目中数据配置设置
* 为内置测试工具提供公开配置入口


   导入头文件  #import "Bugkit.h"

```objc
-(void)initShakeWindow
{
#ifdef DEVELOP
    Class class = NSClassFromString(@"BugKitShakeWindow");
    self.window = [[class alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 项目基础API配置设置
    [BugKitBaseUrlManager registerNetWorkBaseNetInfo:@[@{
                                                           @"name":@"当前环境",
                                                           @"type":@"hostBaseTypeNow",
                                                           @"url":@"https://119.120.88.640"
                                                           },
                                                       @{
                                                           @"name":@"测试环境",
                                                           @"type":@"hostBaseTypeTest",
                                                           @"url":@"https://119.120.88.640"
                                                           },
                                                       @{
                                                           @"name":@"生产环境",
                                                           @"type":@"hostBaseTypeProduct",
                                                           @"url":@"https://lujh.com"
                                                           },
                                                       @{
                                                           @"name":@"类环境",
                                                           @"type":@"hostBaseTypeStaging",
                                                           @"url":@""
                                                           },
                                                       @{
                                                           @"name":@"个人环境",
                                                           @"type":@"hostBaseTypePersonal",
                                                           @"url":@""
                                                           }
                                                       ] changeNotificationName:@"kEnvHostURLChangeNotificationName"];
    
    // 蒲公英API设置
    [BugKitBaseUrlManager sessionStartWithPGYAppKey:@"332ada3b2e4c856c09acc9796cfc9099" APIKey:@"1303c11160b475cc56b9d5df820a17ed" historyUrl:@"https://www.pgyer.com/m6X7"];
#else
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
#endif
}
```

* 蒲谷英历史版本查看URL配置参数如下

  ![(icon)](https://github.com/MrLujh/BugKit/blob/master/resource/json.01.png)

* 蒲谷英API 2.0文档说明链接如下:

    https://www.pgyer.com/doc/view/api#paramInfo
   
### 项目中如何使用
* 网络层的封装，新建一个类来处理基础IP的切换，方便给测试打包和APP上线在同一个版本中不同环境的切换
```objc
#import <Foundation/Foundation.h>

#define kEnvHostURLChangeNotificationName @"kEnvHostURLChangeNotificationName"

@interface LujhBaseUrlManager : NSObject

+(instancetype)sharedInstance;
/** 基础IP */
@property (nonatomic,copy) NSString *hostBaseURL;
@end
```
```objc
#import "LujhBaseUrlManager.h"
#import "LujhNetWorkManager.h"

// 宏设置默认环境Host..
#if (DEVELOP==1)
// Debug
#define DEFAULT_URL_HOST @"https://119.120.88.640"

#else
// Release
#define DEFAULT_URL_HOST @"https://lujh.com"

#endif
@implementation LujhBaseUrlManager
+(instancetype)sharedInstance{
    
    static  LujhBaseUrlManager *baseUrlManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseUrlManager = [[LujhBaseUrlManager alloc] init];
    });
    return baseUrlManager;
}

- (NSString *)hostBaseURL {
    
     return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"hostUrl"] >0?(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"hostUrl"] : DEFAULT_URL_HOST;
}
@end
```
* 更重要的一步是项目中TARGETS 要copy一个新的targets，其作用是copy的那个是用来打包上架App Store，另外一个开放给测试打包，如下图：

 ![(icon)](https://github.com/MrLujh/BugKit/blob/master/resource/network_01.png)

* build settings中预编译宏设置，区分开放版还是上线版本接口切换，如下图:

 ![(icon)](https://github.com/MrLujh/BugKit/blob/master/resource/network_02.png)

 ![(icon)](https://github.com/MrLujh/BugKit/blob/master/resource/network_03.png)

* 导入bugkit之后 库的头文件不需要引入，在APPdelegate

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {}方法中调入

-(void)initShakeWindow
{
    Class class = NSClassFromString(@"BugKitShakeWindow");
    self.window = [[class alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}
```

![Mou icon](https://github.com/MrLujh/Fastlane--Packaging/blob/master/111.gif)
