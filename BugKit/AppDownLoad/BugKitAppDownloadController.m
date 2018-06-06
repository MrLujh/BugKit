//
//  BugKitAppDownloadController.m
//  BugKitExample
//
//  Created by lujh on 2018/3/20.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitAppDownloadController.h"
#import "BugKitDataModel.h"

@interface BugKitAppDownloadController ()
/** dataSource */
@property (nonatomic,strong) NSMutableDictionary *dataSource;
@end

@implementation BugKitAppDownloadController

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 解析数据
    [self parseFileData];
    
    // 蒲谷英平台数据请求
    [self requestNetworkPGY];
}

#pragma mark -解析数据

-(void)parseFileData
{
    NSDictionary *dict = [[BugKitDataModel sharedInstance] getPGYInfomationDict];
    self.dataSource = dict.mutableCopy;
}

#pragma mark -蒲谷英平台数据请求

- (void)requestNetworkPGY
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pgyer.com/apiv2/app/builds"]];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"appKey=%@&_api_key=%@",self.dataSource[@"appKey"],self.dataSource[@"apiKey"]];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        NSString * buildVersionNo = [ [[dict objectForKey:@"data"] objectForKey:@"list"][0] objectForKey:@"buildVersionNo"];
        NSString * buildKey = [ [[dict objectForKey:@"data"] objectForKey:@"list"][0] objectForKey:@"buildKey"];
        NSString* systemAppbuild =  [self getSystemBuild];
        UIAlertController *alert =   [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"当前版本build号: [%@]-蒲公英build号:[%@]",systemAppbuild,buildVersionNo] message:[NSString stringWithFormat:@"蒲公英buildKey: [%@]",buildKey] preferredStyle:UIAlertControllerStyleAlert];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([buildVersionNo integerValue] <= [systemAppbuild integerValue])
            {
                UIAlertAction *cancelAtion = [UIAlertAction actionWithTitle:@"已经是最新版本" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancelAtion];
            }
            else
            {
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"下载最新版本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.pgyer.com/apiv2/app/install?_api_key=%@&buildKey=%@",self.dataSource[@"api_key"],buildKey]]];
                    
                }];
                
                [alert addAction:action1];
                
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"查看历史版本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.dataSource[@"openUrl"]]];
                }];
                [alert addAction:action2];
            }
            
            [self  presentViewController:alert animated:YES completion:^{
            }];
        });
        
    }];
    
    [sessionDataTask resume];
}


- (NSString*) getSystemBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
@end
