//
//  BugKitAPMWindow.m
//  BugKitExample
//
//  Created by lujh on 2018/6/7.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitAPMWindow.h"
#import "BugKitAPMView.h"

@interface BugKitAPMWindow()<UIGestureRecognizerDelegate>
/** apmView */
@property (nonatomic,strong) BugKitAPMView *apmView;
@end

@implementation BugKitAPMWindow

-(id)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert + 100.0;
        self.hidden = YES;
        
        // 初始化Subviews
        [self setupSubviews];
        
        // 摇一摇通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidenAndShowAPMWindow) name:@"kShowAPMWindowNotification" object:nil];
    }
    return self;
}

#pragma mark -摇一摇通知

- (void)hidenAndShowAPMWindow
{
    self.hidden = !self.hidden;
    
    NSDictionary *dict = [[NSDictionary alloc] init];
    if (self.hidden) {
       
        dict = @{@"isShow":@"0"};
    }else {
        
        dict = @{@"isShow":@"1"};
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kStopAPMWindowTimerNotification" object:nil userInfo:dict];
}

#pragma mark -初始化Subviews

-(void)setupSubviews{
    
    self.apmView = [[BugKitAPMView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.apmView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    [self addSubview:self.apmView];
    
    // 添加改变window位置手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
    
    // 2.将拖拽手势添加到图片视图上
    [self addGestureRecognizer:panGestureRecognizer];
}

#pragma mark --改变window位置手势

-(void)changePostion:(UIPanGestureRecognizer *)pan

{
    CGPoint point = [pan translationInView:self];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (pan.state==UIGestureRecognizerStateEnded) {
        CGFloat  fpsx = 0,fpsy=0;
        fpsx = (self.frame.origin.x>width/2.0)?0.15:0.85;
        fpsy = (self.frame.origin.y>height/2.0)?0.15:0.85;
        self.apmView.fpsLab.center = CGPointMake(fpsx*60, fpsy*60);
    }
    
    CGRect originalFrame = self.frame;
    
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
        
        originalFrame.origin.x += point.x;
        
    }
    
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        
        originalFrame.origin.y += point.y;
        
    }
    
    self.frame = originalFrame;
    
    [pan setTranslation:CGPointZero inView:self];
    
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        
        
    } else {
        
        CGRect frame = self.frame;
        
        //记录是否越界
        
        BOOL isOver = NO;
        
        
        
        if (frame.origin.x < 0) {
            
            frame.origin.x = 0;
            
            isOver = YES;
            
        } else if (frame.origin.x+frame.size.width > width) {
            
            frame.origin.x = width - frame.size.width;
            
            isOver = YES;
            
        }
        
        
        
        if (frame.origin.y < 0) {
            
            frame.origin.y = 0;
            
            isOver = YES;
            
        } else if (frame.origin.y+frame.size.height > height) {
            
            frame.origin.y = height - frame.size.height;
            
            isOver = YES;
            
        }
        
        if (isOver) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.frame = frame;
                
            }];
            
        }
    }
}

@end
