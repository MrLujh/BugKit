//
//  DebugSwitchBaseUrlController.m
//  DugKitTest
//
//  Created by lujh on 2018/3/16.
//  Copyright © 2018年 lujh. All rights reserved.
//
#define kCellHeight 44
#define ksectionHeader 40
#define kEnvHostURLChangeNotificationName @"kEnvHostURLChangeNotificationName"

#import "DebugSwitchBaseUrlController.h"

@interface DebugSwitchBaseUrlController ()
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableArray *proNameArray;

@property (strong, nonatomic) NSMutableArray *arr3;

@property (copy , nonatomic) NSIndexPath *seletedPath;
@end

@implementation DebugSwitchBaseUrlController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"切换BaseUrl";
    
    [self creatDataSoure];
    [self.view addSubview:self.tableView];
    
}

- (void)back {
    [self dismissViewControllerAnimated:true completion:nil];
}


-(void)creatDataSoure
{
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"config.json"];
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePatch];
    id json = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [json objectForKey:@"host"];
    self.dataSource = arr.mutableCopy;
    [self.tableView reloadData];
}

- (NSArray *)urlsWithType:(NSInteger)type {
    
    return nil;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ksectionHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.hidden = YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    NSDictionary *typeArray = self.dataSource[section];
    label.text = typeArray[@"name"];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    return  view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indexIdentify = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indexIdentify];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indexIdentify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = self.dataSource[indexPath.section][@"type"];
    cell.detailTextLabel.text = self.dataSource[indexPath.section][@"url"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self addAlert];
    }else {
        
        self.dataSource[0] = self.dataSource[indexPath.section];
        [self writeJsonData];
        [self.tableView reloadData];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kEnvHostURLChangeNotificationName object:nil];
}

- (void)addAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"切换HOST" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"输入host";
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *dic = ((NSDictionary *)weakSelf.dataSource[0]).mutableCopy;
        [dic setValue:alertController.textFields[0].text forKey:@"url"];
        weakSelf.dataSource[0] = dic.copy;
        [weakSelf writeJsonData];
        [weakSelf.tableView reloadData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancel];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)writeJsonData {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"config.json"];
    NSDictionary *dic = @{@"host":self.dataSource};
    NSData *json_data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [json_data writeToFile:filePatch atomically:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
