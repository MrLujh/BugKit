//
//  BugKitSystemStateView.h
//  BugKitExample
//
//  Created by lujh on 2018/6/5.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BugKitSystemStateView : UIView

/* */
@property (copy, nonatomic) NSArray *menuItemsNameArray,*menuBackgroundColorsArray;

/* */
@property (assign,nonatomic) CGFloat menuHeight;

/* */
@property (assign,nonatomic) NSInteger numberOfMenuItem;

/* */
@property (strong, nonatomic) NSMutableArray *menuBtnArray;

/* */
@property (strong, nonatomic) UIButton *mainBtn;
/* */
@property (strong, nonatomic) UILabel *memLab,*cpuLab,*fpsLab;

-(UIView *)hitViewWithPoint:(CGPoint)point superView:(UIView*)sview event:(UIEvent *)event;
@end
