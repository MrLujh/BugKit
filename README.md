# ☆☆☆ “BugKit” ☆☆☆

### 支持pod导入
* pod 'BugKit','~> 3.0.2'

* 如果发现pod search BugKit 搜索出来的不是最新版本，需要在终端执行cd转换文件路径命令退回到desktop，然后执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了


### 项目中数据配置设置
* 为内置测试工具提供公开配置入口


 ![(icon)](https://github.com/MrLujh/BugKit/blob/master/resource/json.03.png)

```objc
{
    "host":[
            {
            "name":"当前环境",
            "type":"hostBaseTypeNow",
            "url":""
            },
            {
            "name":"测试环境",
            "type":"hostBaseTypeTest",
            "url":"https://119.120.88.640"
            },
            {
            "name":"生产环境",
            "type":"hostBaseTypeProduct",
            "url":"https://lujh.com"
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
    "pgyConfig":{
        "appKey":"332ada3b2e4c856c09acc9796cfc9099",
        "api_key":"1303c11160b475cc56b9d5df820a17ed",
        "openUrl":"https://www.pgyer.com/R1mF"
    }
}
```

* 蒲谷英历史版本查看URL配置参数如下

  ![(icon)](https://github.com/MrLujh/BugKit/blob/master/resource/json.01.png)

* 蒲谷英API 2.0文档说明链接如下:

    https://www.pgyer.com/doc/view/api#paramInfo
   
### 项目中如何使用
* 项目中数据配置设置按照上图配置，key value 对照
* 网络层的封装，新建一个类来处理基础IP的切换，方便给测试打包和APP上线在同一个版本中不同环境的切换
```objc
#import <Foundation/Foundation.h>

#define kEnvHostURLChangeNotificationName @"kEnvHostURLChangeNotificationName"

@interface LujhBaseUrlManager : NSObject<NSCoding>

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
        baseUrlManager = [LujhBaseUrlManager getCurrentEnvObjFormUserDefault];
    });
    return baseUrlManager;
}

+ (instancetype)getCurrentEnvObjFormUserDefault {
    
    LujhBaseUrlManager *envDefault = [[LujhBaseUrlManager alloc] init];
    NSString*resourcePath =[[NSBundle mainBundle] pathForResource:@"config.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:resourcePath];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [json objectForKey:@"host"];
    NSMutableArray *muArr = arr.mutableCopy;
    NSMutableDictionary *dic = ((NSDictionary *)muArr[0]).mutableCopy;
    [dic setObject:DEFAULT_URL_HOST forKey:@"url"];
    muArr[0] = dic;
    
    
    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionaryWithDictionary:json];
    [dataDictionary setObject:muArr forKey:@"host"];
    
    NSData *jdata = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONReadingAllowFragments error:nil];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"config.json"];
    [jdata writeToFile:filePath atomically:YES];
    return envDefault;
    
}

- (NSString *)hostBaseURL {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"config.json"];
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePatch];
    id json = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [json objectForKey:@"host"];
    return arr[0][@"url"];
}

@end
```
* 更重要的一步是项目中TARGETS 要copy一个新的targets，其作用是copy的那个是用来打包上架App Store，另外一个开放给测试打包
![(icon)](https://github.com/MrLujh/BugKit/blob/master/resource/network_01.png)
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

```objc
fastlane --version
```
     
      
### 2.打开终端，进入你的项目工程的根目录，输入以下命令

      cd到你项目的目录,执行命令
      
```objc       
fastlane init
```
* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20init_resource/fastlane%20init_01.png)

* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20init_resource/fastlane%20init_02.png)

*  bundl update ---这一步可能时间较长
* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20init_resource/fastlane%20init_03.png)

* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20init_resource/fastlane%20init_04.png)

* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20init_resource/fastlane%20init_05.png)

* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20init_resource/fastlane%20init_06.png)

### 2.蒲公英的Fastlane插件安装
      
      打开终端，进入你的项目工程的根目录，输入以下命令：
      
```objc       
fastlane add_plugin pgyer
```

* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20add_plugin_resource/fastlane%20add_plugin_01.png)

* 这里执行完就可以了
* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20add_plugin_resource/fastlane%20add_plugin_02.png)



### 3.配置Appfile和Fastfile文件 --这里手动配置，直接复制代码就可以了，把里面的配置改成自己的项目

 
       Appfile文件代码如下：
       
```objc

#--发布蒲公英上的版本配置

for_lane :pgy do
  app_identifier "com.zidongdabao.cn" # The bundle identifier of your app
  apple_id "lu287929070@163.com" # Your Apple email address 
end

```

        Fastfile文件文件代码如下：

```objc

# 定义打包平台
default_platform :ios

platform :ios do
  before_all do
    git_pull
    last_git_commit
    sh "rm -f ./Podfile.lock"
       cocoapods(use_bundle_exec: false)

end

# 运行所有的测试
  lane :test do
    scan
end

# 提交一个新的Beta版本
# 确保配置文件是最新的
lane :beta do
   
    gym 
    pilot 
end

# 将新版本部署到应用程序商店
lane :release do
   
    gym 
    deliver(force: true) 
end

# 以下是发布版本的配置

lane :pgy do
    
sigh(
        app_identifier: "com.zidongdabao.cn" #项目的bundle identifler
    )

# 开始打包    
gym(
     
    scheme: “Fastlane--Packaging”, #指定项目的scheme名称
    configuration: "Release", # 指定打包方式，Release 或者 Debug
    silent: true, # 隐藏没有必要的信息
    clean: true, # 是否清空以前的编译信息 true：是
    workspace: "Fastlane--Packaging.xcworkspace",
    include_bitcode: false, #项目中的bitcode 设置
    output_directory: './pgy', # 指定输出文件夹
    output_name: "Fastlane--Packaging.ipa", #输出的ipa名称
    export_xcargs: "-allowProvisioningUpdates”, #忽略文件
    )

# 开始上传蒲公英
pgyer(api_key: "1303c11160b475cc56b9d5df820a17ed", user_key: "dd705842c35567b3f2620e6a047024f0")

end

end

```

* pgyer(api_key: "1303c11160b475cc56b9d5df820a17ed", user_key: "dd705842c35567b3f2620e6a047024f0"),
  在蒲谷英开发平台配置中查看
  
  
* ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/error_resource/error_o4.png)

### 4.在终端执行自动打包 

     在终端输入
```objc 
fastlane pgy
```

 
      一些报错处理：
 * ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/error_resource/error__01.png)
 
 * ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/error_resource/error_02.png)
 
 * ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/error_resource/error_03.png)
 
 
     打包发布成功如下：
 
 * ![(icon)](https://github.com/daniulaolu/Fastlane--Packaging/blob/master/fastlane%20init_resource/fastlane%20init_07.png)
 
 
## AppStore版本的操作和上面流程一样，把Appfile和Fastfile文件修改成发布版本的配置
  
## fatlane --命令说明

  *  scan -- 自动运行测试工具，并且可以生成漂亮的HTML报告
 
  *  cert -- 自动创建管理iOS代码签名证书
  
  *  sigh -- 一声叹息啊，这么多年和Provisioning Profile战斗过无数次。总是有这样那样的问题导致配置文件过期或者失效。sigh是用来创建、更新、下载、    修复Provisioning Profile的工具。
  
  *  pem -- 自动生成、更新推送配置文件
  
  *  match -- 一个新的证书和配置文件管理工具。我会另写一篇文章专门介绍这个工具。他会所有需要用到的证书传到git私有库上，任何需要配置的机器直接用match同步回来就不用管证书问题了，小团队福音啊！   
  
  *  gym -- Fastlane家族的自动化编译工具，和其他工具配合的非常默契
 
  *  produce -- 如果你的产品还没在iTunes Connect(iTC)或者Apple Developer Center(ADC)建立，produce可以自动帮你完成这些工作
  
  *  deliver -- 自动上传截图，APP的元数据，二进制(ipa)文件到iTunes Connect
  
  *  pilot -- 管理TestFlight的测试用户，上传二进制文件

## My weixin
![(author)](https://github.com/daniulaolu/PushParameterWithDict-/blob/master/xiaolu.jpg)

