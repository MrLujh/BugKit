//
//  PGYAppDownloadController.m
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "DebugAppDownloadController.h"
#import <WebKit/WebKit.h>

@interface DebugAppDownloadController ()
/** webView */
@property (nonatomic,strong) WKWebView * webView;
/** installBtn */
@property (nonatomic,strong) UIButton * installBtn;
/** dataSource */
@property (nonatomic,strong) NSMutableDictionary *dataSource;
@end

@implementation DebugAppDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatDataSoure];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    [self checkPGY];
}

-(void)creatDataSoure
{
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"config.json"];
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePatch];
    id json = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dic = [json objectForKey:@"pgyConfig"];
    self.dataSource = dic.mutableCopy;
}

- (void)checkPGY
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pgyer.com/apiv2/app/builds"]];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"appKey=%@&_api_key=%@",self.dataSource[@"appKey"],@"ff41dce0cf87631a6de250077a16b417"];
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
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.pgyer.com/apiv2/app/install?_api_key=%@&buildKey=%@",@"ff41dce0cf87631a6de250077a16b417",buildKey]]];
                    
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
