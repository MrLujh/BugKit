
//
//  TabBarViewController.m
//  StandardArchitecture
//
//  Created by lujh on 2017/7/7.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TLTabBarViewController.h"
#import "TLNavigationViewController.h"
#import "HomeVC.h"
#import "MeVC.h"




@interface TLTabBarViewController ()
@property (nonatomic,assign)NSInteger lastSelectIndex;
@end

@implementation TLTabBarViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有控制器
    [self setUpChildVC];
    
}

#pragma mark -初始化所有控制器（添加控制器）

- (void)setUpChildVC {
    
    HomeVC *vc1 = [[HomeVC alloc] init];
    [self setChildVC:vc1 title:@"首页" image:@"tabbar_icon_home" selectedImage:@"tabbar_icon_home_selected"badgeValue:nil];
    
    MeVC *vc5 = [[MeVC alloc] init];
    vc5.view.backgroundColor = [UIColor whiteColor];
    [self setChildVC:vc5 title:@"我的" image:@"tabbar_icon_mine" selectedImage:@"tabbar_icon_mine_selected"badgeValue:nil];
    
}
    
#pragma mark -tabBarItem样式设置

- (void)setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage badgeValue:(NSString *)badgeValue {
        childVC.tabBarItem.title = title;
        NSMutableDictionary *attr =  [NSMutableDictionary dictionary];
    
    
    //[UIColor grayColor];
    
        NSMutableDictionary *selectAttr =  [NSMutableDictionary dictionary];
    
 
    //[UIColor orangeColor];
        [childVC.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
        [childVC.tabBarItem setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
        childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childVC.tabBarItem.badgeValue = badgeValue;
        TLNavigationViewController *nav = [[TLNavigationViewController alloc] initWithRootViewController:childVC];
        [self addChildViewController:nav];
}

@end
