//
//  HomeVC.m
//  TaiLife
//
//  Created by lujh on 2018/3/14.
//  Copyright © 2018年 TaiKang. All rights reserved.
//  QQ:287929070

#import "HomeVC.h"
#import "TestVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"PuchTestVC" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick
{
    TestVC *VC = [[TestVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
