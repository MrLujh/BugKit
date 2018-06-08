//
//  BugKitAPMView.h
//  BugKitExample
//
//  Created by lujh on 2018/6/7.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BugKitAPMView : UIView
/** 线程 */
@property (nonatomic,strong) NSThread *thread;
/** 定时器 */
@property (nonatomic,strong) NSTimer *timer;
/** 内存label */
@property (nonatomic,strong) UILabel *memLab;
/** CPUlabel */
@property (nonatomic,strong) UILabel *cpuLab;
/** 刷新频率label */
@property (nonatomic,strong) UILabel *fpsLab;
/* */
@property (nonatomic, assign) NSTimeInterval lastUpdateTime;
/* */
@property (assign, nonatomic) NSInteger count;
@end
