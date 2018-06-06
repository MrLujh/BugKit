//
//  BugKitSystemStateViewController.m
//  BugKitExample
//
//  Created by lujh on 2018/6/5.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitSystemStateViewController.h"
#import "TYSystemMonitor.h"
#import "BaseChartView.h"

@interface BugKitSystemStateViewController ()<TYSystemMonitorDelegate>

/* */
@property (weak,nonatomic) UILabel *systemInfoLab,*appCpuInfoLab,*cpuInfoLab,*appMemInfoLab,*memInfoLab;

/* */
@property (strong, nonatomic) NSMutableArray *cpuArr,*cpuCountA,*menArr,*memCountA;

/* */
@property (strong, nonatomic) BaseChartView *chart1,*chart2,*chart3,*chart4;

@end

@implementation BugKitSystemStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cpuArr = [[NSMutableArray alloc] init];
    self.cpuCountA = [[NSMutableArray alloc]init];
    self.menArr = [[NSMutableArray alloc]init];
    self.memCountA = [[NSMutableArray alloc]init];
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat scaleW   = (screen.width / 375.0);
    CGFloat scaleH   = (screen.height==812)?scaleW:(screen.height / 667.0);
    CGFloat SCREEN_WIDTH = screen.width;
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-65*scaleW, 40*scaleH, 40*scaleW, 40*scaleH)];
    [backBtn setTitle:@"X" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(missVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(18*scaleW, 78*scaleH,SCREEN_WIDTH-36*scaleW , 20*scaleH)];
    lab.font = [UIFont systemFontOfSize:14];
    self.systemInfoLab = lab;
    [self.view addSubview:lab];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger i=0; i<20; i++) {
        [self.cpuArr addObject:@0];
        [self.cpuCountA addObject:@""];
    }
    
    
    
    BaseChartView *chart1 = [[BaseChartView alloc]initWithFrame:CGRectMake(18*scaleW, 136*scaleH, SCREEN_WIDTH-36*scaleW, 118*scaleH)];
    self.chart1 = chart1;
    chart1.backgroundColor = [UIColor colorWithRed:241/255.0 green:246/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:chart1];
    
    BaseChartView *chart2 = [[BaseChartView alloc]initWithFrame:CGRectMake(18*scaleW, 264*scaleH, SCREEN_WIDTH-36*scaleW, 118*scaleH)];
    self.chart2 = chart2;
    chart2.minValue = 0.1f;
    chart2.maxValue = 98.9f;
    chart2.backgroundColor = [UIColor colorWithRed:241/255.0 green:246/255.0 blue:255.0/255.0 alpha:1];
    [self.view addSubview:chart2];
    
    
    BaseChartView *chart3 = [[BaseChartView alloc]initWithFrame:CGRectMake(18*scaleW, 394*scaleH, SCREEN_WIDTH-36*scaleW, 118*scaleH)];
    self.chart3 = chart3;
    chart3.backgroundColor = [UIColor colorWithRed:252/255.0 green:245/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:chart3];
    
    BaseChartView *chart4 = [[BaseChartView alloc]initWithFrame:CGRectMake(18*scaleW, 524*scaleH, SCREEN_WIDTH-36*scaleW, 118*scaleH)];
    self.chart4 = chart4;
    chart4.minValue = 0.1f;
    chart4.maxValue = 98.9f;
    chart4.backgroundColor = [UIColor colorWithRed:252/255.0 green:245/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:chart4];
    
    
    [[TYSystemMonitor sharedInstance] start];
    [TYSystemMonitor sharedInstance].delegate = self;
    self.systemInfoLab.text = [NSString stringWithFormat:@"%@: %@ %@",[TYDeviceInfo getDeviceName],[TYDeviceInfo getSystemName], [TYDeviceInfo getSystemVersion]];
}

-(void)changeUI:(UIButton *)btn{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeShowIndex" object:[NSString stringWithFormat:@"%ld",btn.tag]];
}

-(void)missVC{
    [[TYSystemMonitor sharedInstance] stop];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DistroySubVC" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}




#pragma mark - TYSystemMonitorDelegate

- (void)systemMonitor:(TYSystemMonitor *)systemMonitor didUpdateAppCPUUsage:(ty_app_cpu_usage)app_cpu_usage {
    
    self.chart3.titleLab.text = [NSString stringWithFormat:@"AppCPU使用率:%.1f%%",app_cpu_usage.cpu_usage];
    if (self.cpuCountA.count>20) {
        [self.cpuCountA removeObjectAtIndex:0];
    }
    [self.cpuCountA addObject:@(app_cpu_usage.cpu_usage)];
    [self.chart3 updateDataArray:self.cpuCountA];
}







- (void)systemMonitor:(TYSystemMonitor *)systemMonitor didUpdateSystemCPUUsage:(ty_system_cpu_usage)system_cpu_usage {
    self.cpuInfoLab.text = [NSString stringWithFormat:@"%.1f%%",system_cpu_usage.total];
    self.chart1.titleLab.text = [NSString stringWithFormat:@"CPU使用率:%.1f%%",system_cpu_usage.total];
    if (self.cpuArr.count>20) {
        [self.cpuArr removeObjectAtIndex:0];
    }
    [self.cpuArr addObject:@(system_cpu_usage.total)];
    [self.chart1 updateDataArray:self.cpuArr];
    
    
    
}

- (void)systemMonitor:(TYSystemMonitor *)systemMonitor didUpdateAppMemoryUsage:(unsigned long long)app_memory_usage {
    self.appMemInfoLab.text = [NSString stringWithFormat:@"%.1fMB",1.0*app_memory_usage/1024/1024];
    self.chart4.titleLab.text = [NSString stringWithFormat:@"AppMemory:%.1fMB",1.0*app_memory_usage/1024/1024];
    if (self.memCountA.count>20) {
        [self.memCountA removeObjectAtIndex:0];
    }
    [self.memCountA addObject:@(1.0*app_memory_usage/[NSProcessInfo processInfo].physicalMemory*100)];
    [self.chart4 updateDataArray:self.memCountA];
    
    
    
}

- (void)systemMonitor:(TYSystemMonitor *)systemMonitor didUpdateSystemMemoryUsage:(ty_system_memory_usage)system_memory_usage {
    self.memInfoLab.text = [NSString stringWithFormat:@"%.1f%%",100.0*system_memory_usage.used_size/system_memory_usage.total_size];
    
    self.chart2.titleLab.text =  [NSString stringWithFormat:@"SystemMemory:%.1f%%",100.0*system_memory_usage.used_size/system_memory_usage.total_size];
    
    if (self.menArr.count>20) {
        [self.menArr removeObjectAtIndex:0];
    }
    [self.menArr addObject:@(100.0*system_memory_usage.used_size/system_memory_usage.total_size)];
    [self.chart2 updateDataArray:self.menArr];
}

@end
