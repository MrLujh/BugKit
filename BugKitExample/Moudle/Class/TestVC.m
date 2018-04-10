//
//  TestVC.m
//  TaiLife
//
//  Created by lujh on 2018/3/15.
//  Copyright © 2018年 TaiKang. All rights reserved.
//  QQ:287929070

#import "TestVC.h"
#import "LujhNetWorkManager.h"
#import "LujhBaseUrlManager.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[LujhNetWorkManager sharedManager] testBaseUrlWithDic:nil SuccessBlock:^(id  _Nullable responseObject, BOOL isSuccess, NSString * _Nullable msg) {
        
    } failureBlock:^(NSError * _Nullable error) {
        
    }];

    
    NSString *baseUrl = [LujhBaseUrlManager sharedInstance].hostBaseURL;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 300, 60);
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor redColor];
    label.text = baseUrl;
    [self.view addSubview:label];
    label.center = self.view.center;
}

@end
