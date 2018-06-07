//
//  BugKitAPMView.m
//  BugKitExample
//
//  Created by lujh on 2018/6/7.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitAPMView.h"
#import "TYCPUUsage.h"
#import "TYMemoryUsage.h"
#define MENU_START_TAG(offset) (6000 + offset)
#define MENU_NAME_LABEL_TAG(offset) (6100 + offset)
#define ANIMATION_DURATION 0.4
#define MENU_BACKGROUND_VIEW_TAG 6200

@interface BugKitAPMView()
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

@implementation BugKitAPMView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化Subviews
        [self setupSubviewsWithFrame:frame];
        
    }
    return self;
}

#pragma mark -初始化Subviews

-(void)setupSubviewsWithFrame:(CGRect)frame
{
    self.layer.cornerRadius = frame.size.height/2.0;
    self.layer.borderColor = [UIColor greenColor].CGColor;
    self.layer.borderWidth = 1;
    self.backgroundColor = [UIColor grayColor];
    self.memLab = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width / 8.0, frame.size.width / 4.0, frame.size.width * 3 / 4.0, frame.size.width / 4.0)];
    self.memLab.textColor = [UIColor greenColor];
    self.memLab.font = [UIFont systemFontOfSize:12];
    self.memLab.textAlignment = NSTextAlignmentCenter;
    self.memLab.text = @"100M";
    [self addSubview:self.memLab];
    
    UIView *bl = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width *0.1, frame.size.width / 2.0, frame.size.width * 0.8, 1)];
    bl.backgroundColor = [UIColor greenColor];
    [self addSubview:bl];
    
    
    self.cpuLab = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width / 8.0, frame.size.width / 2.0, frame.size.width * 3 / 4.0, frame.size.width / 4.0)];
    self.cpuLab.textColor = [UIColor greenColor];
    self.cpuLab.font = [UIFont systemFontOfSize:7];
    self.cpuLab.textAlignment = NSTextAlignmentCenter;
    self.cpuLab.text = @"1.0%";
    [self addSubview:self.cpuLab];
    
    
    self.fpsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.fpsLab.center = CGPointMake(frame.size.width * 0.85 , frame.size.width * 0.15);
    self.fpsLab.textAlignment = NSTextAlignmentCenter;
    self.fpsLab.backgroundColor = [UIColor greenColor];
    self.fpsLab.textColor = [UIColor blackColor];
    self.fpsLab.font = [UIFont systemFontOfSize:11];
    self.fpsLab.adjustsFontSizeToFitWidth = YES;
    self.fpsLab.text = @"60";
    self.fpsLab.layer.cornerRadius = self.fpsLab.frame.size.height / 2.0;
    self.fpsLab.layer.masksToBounds = YES;
    [self addSubview:self.fpsLab];
    
    [self startMemoryOverFlowMonitor];
    
    [self getFPS];
}

-(void)startMemoryOverFlowMonitor
{
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain) object:nil];
    [_thread setName:@"MemoryOverflowMonitor"];
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(getBtnData) userInfo:nil repeats:YES];
    [_thread start];
}

-(void)threadMain
{
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
    [_timer fire];
}

#pragma =======

-(void)getBtnData{
    //@[@"FPS",@"CPU",@"APP-CPU",@"Memory",@"APP-Mem"
    dispatch_async(dispatch_get_main_queue(), ^{
        self.cpuLab.text = [self getAPPCPU];
        self.memLab.text = [self getAPPMem];
    });
}


-(NSString *)getAPPCPU{
    
    NSString *str =[NSString stringWithFormat:@"CPU:%.1f%%",[TYCPUUsage getAppCPUUsage]];
    return str;
}

-(NSString *)getALLCPU{
    NSString *str =[NSString stringWithFormat:@"%.1f%%",[TYCPUUsage getSystemCPUUsage]];
    return str;
}
-(NSString *)getAPPMem{
    NSString *str =[NSString stringWithFormat:@"%.1fM",[TYMemoryUsage getAppMemoryUsage]/1024.0/1024.0];
    return str;
}
-(NSString *)getSysMen{
    ty_system_memory_usage sms = [TYMemoryUsage getSystemMemoryUsageStruct];
    NSString *str =[NSString stringWithFormat:@"%.1f%%",100.0*sms.used_size/sms.total_size];
    return str;
    
    
}

-(void)getFPS{
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(linkTicks:)] addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)linkTicks:(CADisplayLink *)link
{
    //执行次数
    ++_count;
    //当前时间戳
    if(_lastUpdateTime == 0){
        _lastUpdateTime = link.timestamp;
    }
    CFTimeInterval timePassed = link.timestamp - _lastUpdateTime;
    
    if(timePassed >= 1.f){
        //fps
        CGFloat fps = _count/timePassed;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.fpsLab.text = [NSString stringWithFormat:@"%.0f",fps];
        });
        //reset
        _lastUpdateTime = link.timestamp;
        _count = 0;
    }
}

@end
