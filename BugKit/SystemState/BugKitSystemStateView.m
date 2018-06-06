//
//  BugKitSystemStateView.m
//  BugKitExample
//
//  Created by lujh on 2018/6/5.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitSystemStateView.h"
#import "TYCPUUsage.h"
#import "TYMemoryUsage.h"

@interface BugKitSystemStateView()
{
    NSThread *_thread;
    NSTimer *_timer;
}



/* */
@property (assign, nonatomic)  NSInteger showIndex;

/* */
@property (nonatomic, assign) NSTimeInterval lastUpdateTime;

/* */
@property (assign, nonatomic) NSInteger count;

/* */
@property (assign, nonatomic) BOOL isShowSubVc;

@end

@implementation BugKitSystemStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
        
        self.mainBtn = [[UIButton alloc]initWithFrame:self.bounds];
        self.mainBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.mainBtn];
        self.menuBtnArray = [NSMutableArray array];
        
        [self startMemoryOverFlowMonitor];
        [self getFPS];
    }
    return self;
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
    NSLog(@"%@",str);
    return str;
}

-(NSString *)getALLCPU{
    NSString *str =[NSString stringWithFormat:@"%.1f%%",[TYCPUUsage getSystemCPUUsage]];
    NSLog(@"%@",str);
    return str;
}
-(NSString *)getAPPMem{
    NSString *str =[NSString stringWithFormat:@"%.1fM",[TYMemoryUsage getAppMemoryUsage]/1024.0/1024.0];
    NSLog(@"%@",str);
    return str;
}
-(NSString *)getSysMen{
    ty_system_memory_usage sms = [TYMemoryUsage getSystemMemoryUsageStruct];
    NSString *str =[NSString stringWithFormat:@"%.1f%%",100.0*sms.used_size/sms.total_size];
    NSLog(@"%@",str);
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

-(UIView *)hitViewWithPoint:(CGPoint)point superView:(UIView*)sview event:(UIEvent *)event{
    //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
    CGPoint newP = [sview convertPoint:point toView:self.mainBtn];
    
    //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
    if ( [self.mainBtn pointInside:newP withEvent:event]) {
        return self.mainBtn;
    }else{//如果点不在发布按钮身上，直接让系统处理就可以了
        
        for (UIButton *btn in self.menuBtnArray) {
            CGPoint newP1 = [sview convertPoint:point toView:btn];
            if ( [btn pointInside:newP1 withEvent:event]) {
                return btn;
            }
        }
        return nil;
    }
}

@end
