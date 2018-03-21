//
//  BugkitListTableViewController.m
//  BugKitExample
//
//  Created by lujh on 2018/3/20.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugkitListTableViewController.h"
#import "BugKitSwitchBaseUrlController.h" // 基础网址切换
#import "BugKitAppDownloadController.h" // 蒲谷英下载
#import "FLEXManager.h" // FLEX tools
@interface BugkitListTableViewController ()
/** dataSource */
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation BugkitListTableViewController

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        NSArray *titleArray = @[@"网络请求日志",@"FLEX tools",@"切换BaseUrl",@"蒲公英安装最新版"];
        _dataSource = titleArray.mutableCopy;
    }
    return _dataSource;
}

- (void)viewDidLoad
{
    self.title = @"BugKit内置测试工具";
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
            
        }
            break;
        case 1:
        {
            [[FLEXManager sharedManager] showExplorer];
            [self dismissViewControllerAnimated:true completion:nil];
        }
            break;
        case 2:
        {
            BugKitSwitchBaseUrlController *vc = [[BugKitSwitchBaseUrlController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 3:
        {
            BugKitAppDownloadController *vc = [[BugKitAppDownloadController alloc] init];
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
