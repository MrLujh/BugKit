//
//  DebugListTableViewController.m
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "DebugListTableViewController.h"
#import "DebugSwitchBaseUrlController.h" // 基础网址切换
#import "DebugAppDownloadController.h" // 蒲谷英下载

@interface DebugListTableViewController ()
/** dataSource */
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation DebugListTableViewController
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        NSArray *titleArray = @[@"网络请求日志",@"蒲公英安装最新版",@"FLEX tools",@"切换BaseUrl"];
        _dataSource = titleArray.mutableCopy;
    }
    return _dataSource;
}

- (void)viewDidLoad
{
    self.title = @"Debug";
    __weak typeof(self) weakSelf = self;
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(back)];
        item;
    });
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        
        case 0:
        {
            DebugSwitchBaseUrlController *vc = [[DebugSwitchBaseUrlController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1:
        {
            DebugAppDownloadController *vc = [[DebugAppDownloadController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
}

#pragma mark -导航栏返回按钮点击事件

- (void)back {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
