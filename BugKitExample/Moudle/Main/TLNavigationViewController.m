//
//  TLNavigationViewController.m
//  TaiLife
//
//  Created by WorkMac on 2017/9/25.
//  Copyright © 2017年 TaiKang. All rights reserved.
//

#import "TLNavigationViewController.h"

@interface TLNavigationViewController ()

@end

@implementation TLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -拦截Push事件

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
