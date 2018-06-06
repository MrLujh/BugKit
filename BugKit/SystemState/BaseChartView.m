//
//  BaseChartView.m
//  memoryTest
//
//  Created by user on 2018/5/16.
//  Copyright © 2018年 tk. All rights reserved.
//

#import "BaseChartView.h"

const NSInteger _axisToViewPadding = 10;

const NSInteger _yAxisSpacing = 100;

@interface BaseChartView()

/* */
@property (copy, nonatomic) NSArray *pointYArray;


/* */
@property (strong, nonatomic) NSMutableArray *pointsArray;




/* */
@property (strong, nonatomic) CAShapeLayer *bezierLineLayer;

@end


@implementation BaseChartView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        CGSize screen = [UIScreen mainScreen].bounds.size;
        CGFloat scaleW   = (screen.width / 375.0);
        CGFloat scaleH   = (screen.height==812)?scaleW:(screen.height / 667.0);

        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10*scaleW, 10*scaleH, 180, 22*scaleH)];
        titleLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        titleLab.font = [UIFont systemFontOfSize:14];
        self.titleLab = titleLab;
        [self addSubview:titleLab];
    }
    return self;
    
}



-(NSMutableArray *)pointsArray{
    if (!_pointsArray) {
        _pointsArray = [NSMutableArray array];
    }
    return _pointsArray;
}


-(void)updateDataArray:(NSArray*)arr{
    if (!arr||arr.count==0) {
        return;
    }
    [_bezierLineLayer removeFromSuperlayer];
    self.pointYArray = arr;
    [self.pointsArray removeAllObjects];
    __block CGFloat max = 0.0f;
   __block CGFloat min = 0.0f;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj floatValue]>max) {
            max = [obj floatValue];
        }else if([obj floatValue]<min){
            min = [obj floatValue];
        }
    }];
    if (self.minValue!=0.0) {
        min = self.minValue;
    }
    if (self.maxValue!=0.0) {
        max = self.maxValue;
    }
    
    CGFloat chazhi = max-min+1;
    
    CGFloat scale = (CGRectGetHeight(self.frame) - _axisToViewPadding*2)/chazhi;
    
    CGFloat _xAxisSpacing = (CGRectGetWidth(self.frame) - _axisToViewPadding)/(arr.count+1);
    
    NSValue *firstPointValue = [NSValue valueWithCGPoint:CGPointMake(_axisToViewPadding, ((CGRectGetHeight(self.frame) - _axisToViewPadding) / 2)*scale)];
    [self.pointsArray insertObject:firstPointValue atIndex:0];
    
    __weak typeof(self) weakSelf = self;
    [arr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger objInter = 1;
        if ([obj respondsToSelector:@selector(integerValue)]) {
            objInter = ([obj integerValue]-min)*scale;
        }
        
        CGPoint point = CGPointMake(_xAxisSpacing * (idx+1) + _axisToViewPadding , CGRectGetHeight(weakSelf.frame) - _axisToViewPadding - (objInter - 1));
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
        [weakSelf.pointsArray addObject:value];
        
        if (idx==(weakSelf.pointYArray.count-1)) {
            NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame), ((CGRectGetHeight(self.frame) - _axisToViewPadding) / 2)*scale)];
            [weakSelf.pointsArray addObject:endPointValue];
            [weakSelf drawBLine];
        }
        
    }];
    
    
}


-(void)drawBLine{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < (self.pointYArray.count-1); i++) {
        CGPoint p1 = [[_pointsArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[_pointsArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[_pointsArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[_pointsArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [path moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:path];
    }

    /** 将折线添加到折线图层上，并设置相关的属性 */
    _bezierLineLayer = [CAShapeLayer layer];
    _bezierLineLayer.path = path.CGPath;
    _bezierLineLayer.strokeColor = [UIColor colorWithDisplayP3Red:22/255.0 green:114/255.0 blue:193/255.0 alpha:1].CGColor;
    _bezierLineLayer.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    _bezierLineLayer.lineWidth = 2;
    _bezierLineLayer.lineCap = kCALineCapRound;
    _bezierLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_bezierLineLayer];
    
}

- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path{
    CGFloat smooth_value =0.6;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) /2.0;
    CGFloat yc1 = (y0 + y1) /2.0;
    CGFloat xc2 = (x1 + x2) /2.0;
    CGFloat yc2 = (y1 + y2) /2.0;
    CGFloat xc3 = (x2 + x3) /2.0;
    CGFloat yc3 = (y2 + y3) /2.0;
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}



@end
